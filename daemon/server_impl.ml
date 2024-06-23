open Lwt.Syntax
open Lwt.Infix
open Mpris_client_generic
open Superbird_mpris.Mpris_pb
open React
open Protocol

type op_wrapped (* wrapped OBus_property.t to access methods that return our property_update.t instead of its own thing *) = {
  get : unit -> property_update Lwt.t;
  find : OBus_property.map -> property_update Lwt.t;
}

let server =
  let+ bus = OBus_bus.session () in
  let proxy = OBus_proxy.make ~peer:(OBus_peer.make ~connection:bus ~name:"org.mpris.MediaPlayer2.playerctld") ~path:["org"; "mpris"; "MediaPlayer2"] in
  let wrap_op_lwt : 'a .
    (OBus_proxy.t -> ('a, [> `readable ]) OBus_property.t) ->
    ('a -> property_update Lwt.t) ->
    op_wrapped = fun prop mk ->
    let p = prop proxy in {
      get = (fun () -> OBus_property.get p >>= mk);
      find = (fun map -> OBus_property.find p map |> mk);
    }
  in let wrap_op : 'a .
    (OBus_proxy.t -> ('a, [> `readable ]) OBus_property.t) ->
    ('a -> property_update) ->
    op_wrapped = fun prop mk ->
    wrap_op_lwt prop (fun v -> mk v |> Lwt.return)
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
    (Property_metadata, wrap_op_lwt Org_mpris_MediaPlayer2_Player.metadata (fun (v : (string * OBus_value.V.single) list) ->
      let open OBus_value.C in
      let prop = (Fun.flip List.assoc_opt) v in
      let prop_req = (Fun.flip List.assoc) v in
      let ( ||> ) : 'a 'b. 'a option -> ('a -> 'b) -> 'b option =
        fun a b -> Option.map b a in
      let ( |@> ) : 'a 'b. 'a option -> ('a -> 'b list) -> 'b list =
        fun a b -> Option.fold ~none:[] ~some:b a in
      let+ mpris_art_url_bytes = prop "mpris:artUrl" ||> cast_single basic_string |> function
        | None -> Lwt.return_none
        | Some uri -> (
          let uri = Uri.of_string uri in
          if Uri.scheme uri <> Some "file" then Lwt.return_none else
          let path = uri |> Uri.path |> Uri.pct_decode in
          Lwt_io.with_file ~mode:Lwt_io.Input path (fun channel ->
            Lwt_io.read channel >|= Bytes.unsafe_of_string
          ) >|= Option.some
      ) in
      Metadata {
        o_mpris_trackid = prop_req "mpris:trackid" |> cast_single basic_object_path |> OBus_path.to_string;
        mpris_length = prop "mpris:length" ||> cast_single basic_int64;
        mpris_art_url_bytes;
        xesam_album = prop "xesam:album" ||> cast_single basic_string;
        xesam_album_artist = prop "xesam:albumArtist" |@> cast_single (array basic_string);
        xesam_artist = prop "xesam:artist" |@> cast_single (array basic_string);
        xesam_as_text = prop "xesam:asText" ||> cast_single basic_string;
        xesam_audio_bpm = prop "xesam:audioBPM" ||> cast_single basic_int32;
        xesam_auto_rating = prop "xesam:autoRating" ||> cast_single basic_double;
        xesam_comment = prop "xesam:comment" |@> cast_single (array basic_string);
        xesam_composer = prop "xesam:composer" |@> cast_single (array basic_string);
        d_xesam_content_created = prop "xesam:contentCreated" ||> cast_single basic_string;
        xesam_disc_number = prop "xesam:discNumber" ||> cast_single basic_int32;
        d_xesam_first_used = prop "xesam:firstUsed" ||> cast_single basic_string;
        xesam_genre = prop "xesam:genre" |@> cast_single (array basic_string);
        d_xesam_last_used = prop "xesam:lastUsed" ||> cast_single basic_string;
        xesam_lyricist = prop "xesam:lyricist" |@> cast_single (array basic_string);
        xesam_title = prop "xesam:title" ||> cast_single basic_string;
        xesam_track_number = prop "xesam:trackNumber" ||> cast_single basic_int32;
        xesam_url = prop "xesam:url" ||> cast_single basic_string;
        xesam_use_count = prop "xesam:useCount" ||> cast_single basic_int32;
        xesam_user_rating = prop "xesam:userRating" ||> cast_single basic_double;
      }));
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
        let* v = p.get () in
        push @@ Some (Property v);
        monitor |> Lwt_react.S.map_s (fun m -> let+ v = p.find m in push @@ Some (Property v))
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
    ~ping:(mk_handler_uu (fun _ -> Lwt.return_unit))
    ()
