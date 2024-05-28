open Lwt.Syntax
open Lwt.Infix
open Mpris_client_generic
open Superbird_mpris.Mpris_pb
open Transport
open React

let server =
  let* bus = OBus_bus.session () in
  let proxy = OBus_proxy.make ~peer:(OBus_peer.make ~connection:bus ~name:"org.mpris.MediaPlayer2.playerctld") ~path:["org"; "mpris"; "MediaPlayer2"] in
  (* property tag, dbus property factory, response factory *)
  let props = [
    (Property_can_control, Org_mpris_MediaPlayer2_Player.can_control, fun v -> Can_control v);
    (Property_can_go_next, Org_mpris_MediaPlayer2_Player.can_go_next, fun v -> Can_go_next v);
    (Property_can_go_previous, Org_mpris_MediaPlayer2_Player.can_go_previous, fun v -> Can_go_previous v);
    (Property_can_pause, Org_mpris_MediaPlayer2_Player.can_pause, fun v -> Can_pause v);
    (Property_can_play, Org_mpris_MediaPlayer2_Player.can_play, fun v -> Can_play v);
    (Property_can_seek, Org_mpris_MediaPlayer2_Player.can_seek, fun v -> Can_seek v);
    (* TODO: what happens if property doesn't exist? *)
    (Property_loop_status, Org_mpris_MediaPlayer2_Player.loop_status, fun v -> Loop_status (Value (match v with
      | "None" -> Loop_status_none
      | "Track" -> Loop_status_track
      | "Playlist" -> Loop_status_playlist
      | _ -> failwith "unexpected loop status"
    )));
    (Property_maximum_rate, Org_mpris_MediaPlayer2_Player.maximum_rate, fun v -> Maximum_rate v);
    (Property_metadata, Org_mpris_MediaPlayer2_Player.metadata, fun v -> failwith "TODO");
    (Property_minimum_rate, Org_mpris_MediaPlayer2_Player.minimum_rate, fun v -> Minimum_rate v);
    (Property_playback_status, Org_mpris_MediaPlayer2_Player.playback_status, fun v -> Playback_status (match v with
      | "Playing" -> Playback_status_playing
      | "Paused" -> Playback_status_paused
      | "Stopped" -> Playback_status_stopped
      | _ -> failwith "unexpected playback status"
    ));
    (Property_position, Org_mpris_MediaPlayer2_Player.position, fun v -> Position v);
    (Property_rate, Org_mpris_MediaPlayer2_Player.rate, fun v -> Rate v);
    (Property_shuffle, Org_mpris_MediaPlayer2_Player.shuffle, fun v -> Shuffle (Value v));
    (Property_volume, Org_mpris_MediaPlayer2_Player.volume, fun v -> Volume v);
  ] in


  MPRIS.Server.make
    ~fetchProperty:(mk_handler_uu (fun req ->
      let+ (_, prop, mk) = List.find (fun (p, _, _) -> p = req.property) props in
      prop proxy |> OBus_property.get >|= mk
    ))
    ~subscribe:(mk_handler_us (fun ?switch req ->
      let (stream, push) = Lwt_stream.create () in
      let* monitor =
        OBus_property.group proxy Org_mpris_MediaPlayer2_Player.interface
          |> OBus_property.monitor_group ~switch group in
      let* signals = Lwt_list.map_p (fun (_, prop, mk) ->
        let+ v = prop proxy |> OBus_property.get >|= mk in
        push v;
        monitor
          |> S.map (OBus_property.find (prop proxy))
          |> S.map (fun v -> mk v |> push)
      ) props in
      let+ () = Lwt_switch.add_hook_or_exec switch (fun () ->
        List.iter S.stop signals; Lwt.return_unit
      ) in
      stream
    ))
    ~next:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.next proxy))
    ~openUri:(mk_handler_uu (fun req -> Org_mpris_MediaPlayer2_Player.open_uri proxy ~uri:req.uri))
    ~pause:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.pause proxy))
    ~play:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.play proxy))
    ~playPause:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.play_pause proxy))
    ~previous:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.previous proxy))
    ~seek:(mk_handler_uu (fun req -> Org_mpris_MediaPlayer2_Player.seek proxy ~offset:req.offset))
    ~setPosition:(mk_handler_uu (fun req -> OBus_method.call Org_mpris_MediaPlayer2_Player.m_SetPosition proxy (req.o_track_id, offset)))
    ~stop:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.stop proxy))
    ~setLoopStatus:(mk_handler_uu (fun req -> (match req.loop_status with
      | Loop_status_none -> "None"
      | Loop_status_track -> "Track"
      | Loop_status_playlist -> "Playlist"
    ) |> OBus_property.set (Org_mpris_MediaPlayer2_Player.loop_status proxy)))
    ~setRate:(mk_handler_uu (fun req -> OBus_property.set (Org_mpris_MediaPlayer2_Player.rate proxy) req.rate))
    ~setShuffle:(mk_handler_uu (fun req -> OBus_property.set (Org_mpris_MediaPlayer2_Player.shuffle proxy) req.shuffle))
    ~setVolume:(mk_handler_uu (fun req -> OBus_property.set (Org_mpris_MediaPlayer2_Player.volume proxy) req.volume))
    ()


let () =
	Lwt_main.run (
 		let* md = proxy >|= Org_mpris_MediaPlayer2_Player.metadata in
 		ignore md;
(* 		print_endline md; *)
		Lwt.return_unit
	)
