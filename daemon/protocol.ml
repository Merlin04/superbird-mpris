open Pbrt_services
open Superbird_mpris
open Lwt.Syntax

let encoder_size = 2048

let pbrt_encoder = Pbrt.Encoder.create ~size:encoder_size ()

let encode_with_pbrt_fn (encode : 't -> Pbrt.Encoder.t -> unit) (v : 't) : bytes =
  encode v pbrt_encoder;
  let b = Pbrt.Encoder.to_bytes pbrt_encoder in
  (if Bytes.length b > encoder_size then
    Pbrt.Encoder.reset
  else
    Pbrt.Encoder.clear) pbrt_encoder;
  b

type handler_fn =
  | UnaryUnary of (bytes -> bytes Lwt.t)
  | UnaryStream of (?switch : Lwt_switch.t -> bytes -> bytes Lwt_stream.t Lwt.t)
type handler = { name : string; f : handler_fn }

let decode_req (rpc : ('req, _, _, _) Server.rpc) (b : bytes) : 'req =
  b |> Pbrt.Decoder.of_bytes |> rpc.decode_pb_req

let encode_res (rpc : (_, _, 'res, _) Server.rpc) (res : 'res) : bytes =
  encode_with_pbrt_fn rpc.encode_pb_res res

let mk_handler_uu
  (f : 'req -> 'res Lwt.t)
  (rpc : ('req, Value_mode.unary, 'res, Value_mode.unary) Server.rpc) : handler =
    { name = rpc.name; f = UnaryUnary (fun b ->
      let req = decode_req rpc b in
      let+ res = f req in
      encode_res rpc res
    ) }

let mk_handler_us
  (f : ?switch : Lwt_switch.t -> 'req -> 'res Lwt_stream.t Lwt.t)
  (rpc : ('req, Value_mode.unary, 'res, Value_mode.stream) Server.rpc) : handler =
    { name = rpc.name; f = UnaryStream (fun ?switch b ->
      let req = decode_req rpc b in
      let+ res_stream = f ?switch req in
      Lwt_stream.map (encode_res rpc) res_stream
    ) }

let decode_rpc_call_frame (fr : bytes) : Mpris_pb.rpc_call =
  fr
    |> Pbrt.Decoder.of_bytes
    |> Mpris_pb.decode_pb_rpc_call

let make_dependent_of (source : Lwt_switch.t) (dep : Lwt_switch.t) =
  Lwt_switch.add_hook_or_exec (Some source) (fun () -> Lwt_switch.turn_off dep)

let run (server : handler Pbrt_services.Server.t) (transport : Transport.t) : unit Lwt.t =
  let transport_switch = Lwt_switch.create () in
  let handle_rpc_call_frame (fr : bytes) : unit Lwt.t =
    let { Mpris_pb.call_id; Mpris_pb.name; Mpris_pb.req; } = decode_rpc_call_frame fr in
    let write_response (res : bytes option) =
      encode_with_pbrt_fn Mpris_pb.encode_pb_rpc_response { call_id; res } |> transport.write_frame
    in
    let handler = List.find (fun h -> h.name = name) server.handlers in
    match handler.f with
      | UnaryUnary f -> (
        let* res = f req in
        write_response (Some res)
      )
      | UnaryStream f -> (
        let switch = Lwt_switch.create () in
        let* () = switch |> make_dependent_of transport_switch in
        let* stream = f ~switch req in
        let* () = Lwt_stream.iter_s (fun res ->
          write_response (Some res)
        ) stream in
        (* stream closed *)
        let* () = Lwt_switch.turn_off switch in
        write_response None
      )
  in
  let handler_thread = Lwt_stream.iter_p handle_rpc_call_frame transport.incoming_frames in
  let close_thread =
    let* () = Lwt_stream.closed transport.incoming_frames in
    Lwt_switch.turn_off transport_switch
  in
  Lwt.pick [handler_thread; close_thread]
