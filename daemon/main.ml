open Lwt.Syntax
open Lwt.Infix
open Mpris_client_generic
open Superbird_mpris.Mpris_pb
open Transport

let server =
  let* bus = OBus_bus.session () in
  let+ proxy = OBus_proxy.make ~peer:(OBus_peer.make ~connection:bus ~name:"org.mpris.MediaPlayer2.playerctld") ~path:["org"; "mpris"; "MediaPlayer2"]
  MPRIS.Server.make
    ~fetchProperty:(mk_handler (fun req ->
      match req.property with
        | Property_can_control ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_control proxy |> OBus_property.get in
          Can_control v
        | Property_can_go_next ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_go_next |> OBus_property.get in
          Can_go_next v
        | Property_can_go_previous ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_go_previous |> OBus_property.get in
          Can_go_previous v
        | Property_can_pause ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_pause |> OBus_property.get in
          Can_pause v
        | Property_can_play ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_play |> OBus_property.get in
          Can_play v
        | Property_can_seek ->
          let+ v = Org_mpris_MediaPlayer2_Player.can_seek |> OBus_property.get in
          Can_seek v
        | Property_loop_status ->
          (* TODO: what happens if property doesn't exist? *)
          let+ v = Org_mpris_MediaPlayer2_Player.loop_status proxy |> OBus_property.get in
          Loop_status (Value (match v with
            | "None" -> Loop_status_none
            | "Track" -> Loop_status_track
            | "Playlist" -> Loop_status_playlist
            | _ -> failwith "unexpected loop status"
          ))
        | Property_maximum_rate ->
          let+ v = Org_mpris_MediaPlayer2_Player.maximum_rate proxy |> OBus_property.get in
          Maximum_rate v
        | Property_metadata ->
          (* TODO: not a simple type *)
          failwith "TODO"
        | Property_minimum_rate ->
          let+ v = Org_mpris_MediaPlayer2_Player.minimum_rate proxy |> OBus_property.get in
          Minimum_rate v
        | Property_playback_status ->
          let+ v = Org_mpris_MediaPlayer2_Player.playback_status proxy |> OBus_property.get in
          Playback_status (match v with
            | "Playing" -> Playback_status_playing
            | "Paused" -> Playback_status_paused
            | "Stopped" -> Playback_status_stopped
            | _ -> failwith "unexpected playback status"
          )
        | Property_position ->
          let+ v = Org_mpris_MediaPlayer2_Player.position proxy |> OBus_property.get in
          Position v
        | Property_rate ->
          let+ v = Org_mpris_MediaPlayer2_Player.rate proxy |> OBus_property.get in
          Rate v
        | Property_shuffle ->
          let+ v = Org_mpris_MediaPlayer2_Player.shuffle proxy |> OBus_property.get in
          Shuffle (Value v)
        | Property_volume ->
          let+ v = Org_mpris_MediaPlayer2_Player.volume proxy |> OBus_property.get in
          Volume v
    ))

    ~subscribe:(mk_handler (fun req ->
      let (stream, push) = Lwt_stream.create () in
      let* monitor =
        OBus_property.group proxy Org_mpris_MediaPlayer2_Player.interface
          |> OBus_property.monitor_group group in
      (* TODO: maybe don't use a group? because then we don't have the nice typings that properties have *)

    ))
    ()


let () =
	Lwt_main.run (
 		let* md = proxy >|= Org_mpris_MediaPlayer2_Player.metadata in
 		ignore md;
(* 		print_endline md; *)
		Lwt.return_unit
	)
