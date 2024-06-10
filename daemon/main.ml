open Lwt.Syntax

let () =
	Lwt_main.run (
	  let port = Serial.get_serial_port_path () in
	  print_endline @@ "Connecting to " ^ port;
	  let* transport = Serial.make_transport port in
	  let* server = Server_impl.server in
	  let* () = Protocol.run server transport in
	  print_endline "Disconnected";
		Lwt.return_unit
	)
