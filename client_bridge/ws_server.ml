open Superbird_mpris
open Websocket_lwt_unix

(* passes ownership of bytes to the returned frame *)
let binary_frame_to_ws (b : bytes) : Websocket.Frame.t =
  let open Websocket.Frame in
  create
    ~opcode:Opcode.Binary
    ~content:(Bytes.unsafe_to_string b)
    ()

(* passes ownership of frame to the returned bytes *)
let ws_frame_to_binary (f : Websocket.Frame.t) : bytes option =
  let open Websocket.Frame in
  match f.opcode with
    | Opcode.Binary | Opcode.Text -> Some (Bytes.unsafe_of_string f.content)
    | _ -> None

let run (transport : Transport.t) : unit Lwt.t =
  establish_standard_server
    ~mode:(`TCP (`Port 1337))
    (fun (client : Connected_client.t) ->
      print_endline "Client connected!";
      let recv_thread = mk_frame_stream (fun () -> Connected_client.recv client)
        |> Lwt_stream.iter_p (fun f -> f |> ws_frame_to_binary |> function
          | Some f -> transport.write_frame f
          | None -> Lwt.return_unit)
      in
      let send_thread = transport.incoming_frames
        |> Lwt_stream.iter_p (fun f -> f |> binary_frame_to_ws |> Connected_client.send client)
      in
      (* if one crashes, we don't want to continue running the other *)
      Lwt.pick [recv_thread; send_thread]
    )