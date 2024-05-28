open Pbrt_services

type handler =
  | UnaryUnary : {
      rpc: ('req, Value_mode.unary, 'res, Value_mode.unary) Server.rpc;
      f: 'req -> 'res Lwt.t
    } -> handler
  | UnaryStream : {
      rpc: ('req, Value_mode.unary, 'res, Value_mode.stream) Server.rpc;
      f : ?switch : Lwt_switch.t -> 'req -> 'res Lwt_stream.t
    } -> handler

let mk_handler_uu f rpc = UnaryUnary { rpc; f }
let mk_handler_us f rpc = UnaryStream { rpc; f }