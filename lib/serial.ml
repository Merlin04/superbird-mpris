open Lwt.Syntax

let read_until_delim ~(d : char) ~(buf_size : int) ic : bytes Lwt.t =
  let buf = Buffer.create buf_size in
  let rec loop () =
    let* c = Lwt_io.read_char ic in
    if c = d then Lwt.return (Buffer.to_bytes buf) else (
      Buffer.add_char buf c;
      loop ()
    )
  in loop ()

let make_transport (port : string) : Transport.t Lwt.t =
  let+ fd = Lwt_unix.openfile port [Unix.O_RDWR; Unix.O_NONBLOCK] 0o000 in
  let ic = Lwt_io.of_fd fd ~mode:Lwt_io.input in
  let oc = Lwt_io.of_fd fd ~mode:Lwt_io.output in
  let read_frame () =
    let+ frame = read_until_delim ~d:Cobs.default_delim ~buf_size:Pb.encoder_size ic in
    Cobs.from_cobs frame
  in
  let incoming_frames = Lwt_stream.from (fun () ->
    Lwt.catch (fun () ->
      let+ f = read_frame () in Some f
    ) (fun _ -> Lwt.return_none)
  ) in
  let write_frame b =
    let c = Cobs.to_cobs b in
    (* unfortunately this ends up converting to a string and back, Lwt doesn't have its internal *)
    (* [unsafe_write_from_exactly] function exposed. hopefully this isn't too much overhead *)
    let* () = Lwt_io.write oc (Bytes.unsafe_to_string c) in
    Lwt_io.write_char oc Cobs.default_delim
  in
  Transport.({ incoming_frames; write_frame })