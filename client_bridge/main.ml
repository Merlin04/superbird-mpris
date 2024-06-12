open Lwt.Syntax
open Superbird_mpris

let rec main () : unit Lwt.t =
  let* port = Serial_port.serial_port_gadget_path in
  print_endline @@ "Found USB serial gadget device: " ^ port;
  let* transport = Serial.make_transport port in
  let* () = Ws_server.run transport in
  print_endline "Server thread unexpectedly ended, restarting...";
  main ()

let () =
  Lwt_main.run (main ())