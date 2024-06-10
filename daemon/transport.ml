type t = {
  incoming_frames : bytes Lwt_stream.t;
  write_frame : bytes -> unit Lwt.t;
}