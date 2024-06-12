(** A generic IO device that can receive and send binary frames *)
type t = {
  incoming_frames : bytes Lwt_stream.t;
  write_frame : bytes -> unit Lwt.t;
}