open Pbrt_services

type handler =
  | UnaryUnary {
    rpc: ('req, Value_mode.unary, 'res, Value_mode.unary) Server.rpc;
    f: 'req -> 'res Lwt.t
  } | UnaryStream {
    rpc: ('req, Value_mode.unary, 'res, Value_mode.stream) Server.rpc;
    f : 'req -> 'res Lwt_stream.t
  }

let mk_handler f (rpc : Server.rpc) = match rpc.req_mode, rpc.res_mode with
  | Value_mode.unary, Value_mode.unary -> UnaryUnary { rpc; f }
  | Value_mode.unary, Value_mode.stream -> UnaryStream { rpc; f }
  | _ -> failwith "Unsupported RPC mode"