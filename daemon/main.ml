open Lwt.Syntax
open Superbird_mpris

let rec main () : unit Lwt.t =
  let port = Serial_port.get_serial_port_path () in
  print_endline @@ "Connecting to " ^ port;
  let* transport = Serial.make_transport port in
  let* server = Server_impl.server in
  let* () = Protocol.run server transport in
  print_endline "Disconnected";
  main ()

let () =
	Lwt_main.run (main ())
