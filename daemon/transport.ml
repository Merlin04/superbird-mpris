open Pbrt_services
open Superbird_mpris

type handler =
  | UnaryUnary : {
      rpc : ('req, Value_mode.unary, 'res, Value_mode.unary) Server.rpc;
      f: 'req -> 'res Lwt.t
    } -> handler
  | UnaryStream : {
      rpc : ('req, Value_mode.unary, 'res, Value_mode.stream) Server.rpc;
      f : ?switch : Lwt_switch.t -> 'req -> 'res Lwt_stream.t Lwt.t
    } -> handler

let mk_handler_uu f rpc = UnaryUnary { rpc; f }
let mk_handler_us f rpc = UnaryStream { rpc; f }

let encoder_size = 2048

let pbrt_encoder = Pbrt.Encoder.create ~size:encoder_size ()

let encode_rpc_response (res : Mpris_pb.rpc_response) : bytes =
  Mpris_pb.encode_pb_rpc_response res pbrt_encoder;
  let b = Pbrt.Encoder.to_bytes pbrt_encoder in
  (if Bytes.length b > encoder_size then
    Pbrt.Encoder.reset
  else
    Pbrt.Encoder.clear) pbrt_encoder;
  b |> Cobs.to_cobs

let decode_rpc_call (req : bytes) : Mpris_pb.rpc_call =
  req
    |> Cobs.from_cobs
    |> Pbrt.Decoder.of_bytes
    |> Mpris_pb.decode_pb_rpc_call

(* let handle_request (server : handler Pbrt_services.Server.t) (req : request) = *)
