open Lwt.Syntax
open Lwt.Infix
open Mpris_client_generic
open Superbird_mpris.Mpris_pb
open React
open Protocol

type op_wrapped (* wrapped OBus_property.t to access methods that return our property_update.t instead of its own thing *) = {
  get : unit -> property_update Lwt.t;
  find : OBus_property.map -> property_update;
}

let server =
  let+ bus = OBus_bus.session () in
  let proxy = OBus_proxy.make ~peer:(OBus_peer.make ~connection:bus ~name:"org.mpris.MediaPlayer2.playerctld") ~path:["org"; "mpris"; "MediaPlayer2"] in
  let wrap_op : 'a . (OBus_proxy.t -> ('a, [> `readable ]) OBus_property.t) -> ('a -> property_update) -> op_wrapped = fun prop mk ->
    let p = prop proxy in {
      get = (fun () -> OBus_property.get p >|= mk);
      find = (fun map -> OBus_property.find p map |> mk);
    }
  in
  let props : (property * op_wrapped) list = [
    (Property_can_control, wrap_op Org_mpris_MediaPlayer2_Player.can_control (fun v -> Can_control v));
    (Property_can_go_next, wrap_op Org_mpris_MediaPlayer2_Player.can_go_next (fun v -> Can_go_next v));
    (Property_can_go_previous, wrap_op Org_mpris_MediaPlayer2_Player.can_go_previous (fun v -> Can_go_previous v));
    (Property_can_pause, wrap_op Org_mpris_MediaPlayer2_Player.can_pause (fun v -> Can_pause v));
    (Property_can_play, wrap_op Org_mpris_MediaPlayer2_Player.can_play (fun v -> Can_play v));
    (Property_can_seek, wrap_op Org_mpris_MediaPlayer2_Player.can_seek (fun v -> Can_seek v));
    (* TODO: what happens if property doesn't exist? *)
    (Property_loop_status, wrap_op Org_mpris_MediaPlayer2_Player.loop_status (fun v -> Loop_status (Value (match v with
      | "None" -> Loop_status_none
      | "Track" -> Loop_status_track
      | "Playlist" -> Loop_status_playlist
      | _ -> failwith "unexpected loop status"
    ))));
    (Property_maximum_rate, wrap_op Org_mpris_MediaPlayer2_Player.maximum_rate (fun v -> Maximum_rate v));
    (Property_metadata, wrap_op Org_mpris_MediaPlayer2_Player.metadata (fun _ -> failwith "TODO"));
    (Property_minimum_rate, wrap_op Org_mpris_MediaPlayer2_Player.minimum_rate (fun v -> Minimum_rate v));
    (Property_playback_status, wrap_op Org_mpris_MediaPlayer2_Player.playback_status (fun v -> Playback_status (match v with
      | "Playing" -> Playback_status_playing
      | "Paused" -> Playback_status_paused
      | "Stopped" -> Playback_status_stopped
      | _ -> failwith "unexpected playback status"
    )));
    (Property_position, wrap_op Org_mpris_MediaPlayer2_Player.position (fun v -> Position v));
    (Property_rate, wrap_op Org_mpris_MediaPlayer2_Player.rate (fun v -> Rate v));
    (Property_shuffle, wrap_op Org_mpris_MediaPlayer2_Player.shuffle (fun v -> Shuffle (Value v)));
    (Property_volume, wrap_op Org_mpris_MediaPlayer2_Player.volume (fun v -> Volume v));
  ] in


  MPRIS.Server.make
    ~fetchProperty:(mk_handler_uu (fun req ->
      let (_, { get; _ }) = List.find (fun (p, _) -> p = req.property) props in get ()
    ))
    ~subscribe:(mk_handler_us (fun ?switch _ ->
      let (stream, push) = Lwt_stream.create () in
      let* monitor =
        OBus_property.group proxy Mpris_interfaces.Org_mpris_MediaPlayer2_Player.interface
          |> OBus_property.monitor_group ?switch in
      let* react_signals = Lwt_list.map_p (fun (_, p) ->
        let+ v = p.get () in
        push @@ Some (Property v);
        monitor |> S.map (fun m -> push @@ Some (Property (p.find m)))
      ) props in
      let+ () = Lwt_switch.add_hook_or_exec switch (fun () ->
        List.iter S.stop react_signals; Lwt.return_unit
      ) in
      stream
    ))
    ~next:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.next proxy))
    ~openUri:(mk_handler_uu (fun req -> Org_mpris_MediaPlayer2_Player.open_uri proxy ~uri:req.uri))
    ~pause:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.pause proxy))
    ~play:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.play proxy))
    ~playPause:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.play_pause proxy))
    ~previous:(mk_handler_uu (fun _ -> Org_mpris_MediaPlayer2_Player.previous proxy))
    ~seek:(mk_handler_uu (fun (req : seek_request) -> Org_mpris_MediaPlayer2_Player.seek proxy ~offset:req.offset))
    ~setPosition:(mk_handler_uu (fun req -> OBus_method.call Mpris_interfaces.Org_mpris_MediaPlayer2_Player.m_SetPosition proxy (OBus_path.of_string req.o_track_id, req.offset)))
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
