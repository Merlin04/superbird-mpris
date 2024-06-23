
(** Code for mpris_pb.proto *)

(* generated from "mpris_pb.proto", do not edit *)



(** {2 Types} *)

type empty = unit

type loop_status =
  | Loop_status_none 
  | Loop_status_track 
  | Loop_status_playlist 

type property =
  | Property_can_control 
  | Property_can_go_next 
  | Property_can_go_previous 
  | Property_can_pause 
  | Property_can_play 
  | Property_can_seek 
  | Property_loop_status 
  | Property_maximum_rate 
  | Property_metadata 
  | Property_minimum_rate 
  | Property_playback_status 
  | Property_position 
  | Property_rate 
  | Property_shuffle 
  | Property_volume 

type loop_status_optional =
  | None
  | Value of loop_status

type shuffle_optional =
  | None
  | Value of bool

type property_update_playback_status =
  | Playback_status_playing 
  | Playback_status_paused 
  | Playback_status_stopped 

type property_update_metadata = {
  o_mpris_trackid : string;
  mpris_length : int64 option;
  mpris_art_url_bytes : bytes option;
  xesam_album : string option;
  xesam_album_artist : string list;
  xesam_artist : string list;
  xesam_as_text : string option;
  xesam_audio_bpm : int32 option;
  xesam_auto_rating : float option;
  xesam_comment : string list;
  xesam_composer : string list;
  d_xesam_content_created : string option;
  xesam_disc_number : int32 option;
  d_xesam_first_used : string option;
  xesam_genre : string list;
  d_xesam_last_used : string option;
  xesam_lyricist : string list;
  xesam_title : string option;
  xesam_track_number : int32 option;
  xesam_url : string option;
  xesam_use_count : int32 option;
  xesam_user_rating : float option;
}

type property_update =
  | Can_control of bool
  | Can_go_next of bool
  | Can_go_previous of bool
  | Can_pause of bool
  | Can_play of bool
  | Can_seek of bool
  | Loop_status of loop_status_optional
  | Maximum_rate of float
  | Metadata of property_update_metadata
  | Minimum_rate of float
  | Playback_status of property_update_playback_status
  | Position of int64
  | Rate of float
  | Shuffle of shuffle_optional
  | Volume of float

type set_loop_status_request = {
  loop_status : loop_status;
}

type set_rate_request = {
  rate : float;
}

type set_shuffle_request = {
  shuffle : bool;
}

type set_volume_request = {
  volume : float;
}

type signal_update_seeked = {
  position : int64;
}

type signal_update =
  | Seeked of signal_update_seeked

type fetch_property_request = {
  property : property;
}

type update =
  | Property of property_update
  | Signal of signal_update

type open_uri_request = {
  uri : string;
}

type seek_request = {
  offset : int64;
}

type set_position_request = {
  o_track_id : string;
  offset : int64;
}

type rpc_call = {
  call_id : int64;
  name : string;
  req : bytes;
}

type rpc_response = {
  call_id : int64;
  res : bytes option;
}


(** {2 Basic values} *)

val default_empty : unit
(** [default_empty ()] is the default value for type [empty] *)

val default_loop_status : unit -> loop_status
(** [default_loop_status ()] is the default value for type [loop_status] *)

val default_property : unit -> property
(** [default_property ()] is the default value for type [property] *)

val default_loop_status_optional : unit -> loop_status_optional
(** [default_loop_status_optional ()] is the default value for type [loop_status_optional] *)

val default_shuffle_optional : unit -> shuffle_optional
(** [default_shuffle_optional ()] is the default value for type [shuffle_optional] *)

val default_property_update_playback_status : unit -> property_update_playback_status
(** [default_property_update_playback_status ()] is the default value for type [property_update_playback_status] *)

val default_property_update_metadata : 
  ?o_mpris_trackid:string ->
  ?mpris_length:int64 option ->
  ?mpris_art_url_bytes:bytes option ->
  ?xesam_album:string option ->
  ?xesam_album_artist:string list ->
  ?xesam_artist:string list ->
  ?xesam_as_text:string option ->
  ?xesam_audio_bpm:int32 option ->
  ?xesam_auto_rating:float option ->
  ?xesam_comment:string list ->
  ?xesam_composer:string list ->
  ?d_xesam_content_created:string option ->
  ?xesam_disc_number:int32 option ->
  ?d_xesam_first_used:string option ->
  ?xesam_genre:string list ->
  ?d_xesam_last_used:string option ->
  ?xesam_lyricist:string list ->
  ?xesam_title:string option ->
  ?xesam_track_number:int32 option ->
  ?xesam_url:string option ->
  ?xesam_use_count:int32 option ->
  ?xesam_user_rating:float option ->
  unit ->
  property_update_metadata
(** [default_property_update_metadata ()] is the default value for type [property_update_metadata] *)

val default_property_update : unit -> property_update
(** [default_property_update ()] is the default value for type [property_update] *)

val default_set_loop_status_request : 
  ?loop_status:loop_status ->
  unit ->
  set_loop_status_request
(** [default_set_loop_status_request ()] is the default value for type [set_loop_status_request] *)

val default_set_rate_request : 
  ?rate:float ->
  unit ->
  set_rate_request
(** [default_set_rate_request ()] is the default value for type [set_rate_request] *)

val default_set_shuffle_request : 
  ?shuffle:bool ->
  unit ->
  set_shuffle_request
(** [default_set_shuffle_request ()] is the default value for type [set_shuffle_request] *)

val default_set_volume_request : 
  ?volume:float ->
  unit ->
  set_volume_request
(** [default_set_volume_request ()] is the default value for type [set_volume_request] *)

val default_signal_update_seeked : 
  ?position:int64 ->
  unit ->
  signal_update_seeked
(** [default_signal_update_seeked ()] is the default value for type [signal_update_seeked] *)

val default_signal_update : unit -> signal_update
(** [default_signal_update ()] is the default value for type [signal_update] *)

val default_fetch_property_request : 
  ?property:property ->
  unit ->
  fetch_property_request
(** [default_fetch_property_request ()] is the default value for type [fetch_property_request] *)

val default_update : unit -> update
(** [default_update ()] is the default value for type [update] *)

val default_open_uri_request : 
  ?uri:string ->
  unit ->
  open_uri_request
(** [default_open_uri_request ()] is the default value for type [open_uri_request] *)

val default_seek_request : 
  ?offset:int64 ->
  unit ->
  seek_request
(** [default_seek_request ()] is the default value for type [seek_request] *)

val default_set_position_request : 
  ?o_track_id:string ->
  ?offset:int64 ->
  unit ->
  set_position_request
(** [default_set_position_request ()] is the default value for type [set_position_request] *)

val default_rpc_call : 
  ?call_id:int64 ->
  ?name:string ->
  ?req:bytes ->
  unit ->
  rpc_call
(** [default_rpc_call ()] is the default value for type [rpc_call] *)

val default_rpc_response : 
  ?call_id:int64 ->
  ?res:bytes option ->
  unit ->
  rpc_response
(** [default_rpc_response ()] is the default value for type [rpc_response] *)


(** {2 Protobuf Encoding} *)

val encode_pb_empty : empty -> Pbrt.Encoder.t -> unit
(** [encode_pb_empty v encoder] encodes [v] with the given [encoder] *)

val encode_pb_loop_status : loop_status -> Pbrt.Encoder.t -> unit
(** [encode_pb_loop_status v encoder] encodes [v] with the given [encoder] *)

val encode_pb_property : property -> Pbrt.Encoder.t -> unit
(** [encode_pb_property v encoder] encodes [v] with the given [encoder] *)

val encode_pb_loop_status_optional : loop_status_optional -> Pbrt.Encoder.t -> unit
(** [encode_pb_loop_status_optional v encoder] encodes [v] with the given [encoder] *)

val encode_pb_shuffle_optional : shuffle_optional -> Pbrt.Encoder.t -> unit
(** [encode_pb_shuffle_optional v encoder] encodes [v] with the given [encoder] *)

val encode_pb_property_update_playback_status : property_update_playback_status -> Pbrt.Encoder.t -> unit
(** [encode_pb_property_update_playback_status v encoder] encodes [v] with the given [encoder] *)

val encode_pb_property_update_metadata : property_update_metadata -> Pbrt.Encoder.t -> unit
(** [encode_pb_property_update_metadata v encoder] encodes [v] with the given [encoder] *)

val encode_pb_property_update : property_update -> Pbrt.Encoder.t -> unit
(** [encode_pb_property_update v encoder] encodes [v] with the given [encoder] *)

val encode_pb_set_loop_status_request : set_loop_status_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_set_loop_status_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_set_rate_request : set_rate_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_set_rate_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_set_shuffle_request : set_shuffle_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_set_shuffle_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_set_volume_request : set_volume_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_set_volume_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_signal_update_seeked : signal_update_seeked -> Pbrt.Encoder.t -> unit
(** [encode_pb_signal_update_seeked v encoder] encodes [v] with the given [encoder] *)

val encode_pb_signal_update : signal_update -> Pbrt.Encoder.t -> unit
(** [encode_pb_signal_update v encoder] encodes [v] with the given [encoder] *)

val encode_pb_fetch_property_request : fetch_property_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_fetch_property_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_update : update -> Pbrt.Encoder.t -> unit
(** [encode_pb_update v encoder] encodes [v] with the given [encoder] *)

val encode_pb_open_uri_request : open_uri_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_open_uri_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_seek_request : seek_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_seek_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_set_position_request : set_position_request -> Pbrt.Encoder.t -> unit
(** [encode_pb_set_position_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_rpc_call : rpc_call -> Pbrt.Encoder.t -> unit
(** [encode_pb_rpc_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_rpc_response : rpc_response -> Pbrt.Encoder.t -> unit
(** [encode_pb_rpc_response v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_empty : Pbrt.Decoder.t -> empty
(** [decode_pb_empty decoder] decodes a [empty] binary value from [decoder] *)

val decode_pb_loop_status : Pbrt.Decoder.t -> loop_status
(** [decode_pb_loop_status decoder] decodes a [loop_status] binary value from [decoder] *)

val decode_pb_property : Pbrt.Decoder.t -> property
(** [decode_pb_property decoder] decodes a [property] binary value from [decoder] *)

val decode_pb_loop_status_optional : Pbrt.Decoder.t -> loop_status_optional
(** [decode_pb_loop_status_optional decoder] decodes a [loop_status_optional] binary value from [decoder] *)

val decode_pb_shuffle_optional : Pbrt.Decoder.t -> shuffle_optional
(** [decode_pb_shuffle_optional decoder] decodes a [shuffle_optional] binary value from [decoder] *)

val decode_pb_property_update_playback_status : Pbrt.Decoder.t -> property_update_playback_status
(** [decode_pb_property_update_playback_status decoder] decodes a [property_update_playback_status] binary value from [decoder] *)

val decode_pb_property_update_metadata : Pbrt.Decoder.t -> property_update_metadata
(** [decode_pb_property_update_metadata decoder] decodes a [property_update_metadata] binary value from [decoder] *)

val decode_pb_property_update : Pbrt.Decoder.t -> property_update
(** [decode_pb_property_update decoder] decodes a [property_update] binary value from [decoder] *)

val decode_pb_set_loop_status_request : Pbrt.Decoder.t -> set_loop_status_request
(** [decode_pb_set_loop_status_request decoder] decodes a [set_loop_status_request] binary value from [decoder] *)

val decode_pb_set_rate_request : Pbrt.Decoder.t -> set_rate_request
(** [decode_pb_set_rate_request decoder] decodes a [set_rate_request] binary value from [decoder] *)

val decode_pb_set_shuffle_request : Pbrt.Decoder.t -> set_shuffle_request
(** [decode_pb_set_shuffle_request decoder] decodes a [set_shuffle_request] binary value from [decoder] *)

val decode_pb_set_volume_request : Pbrt.Decoder.t -> set_volume_request
(** [decode_pb_set_volume_request decoder] decodes a [set_volume_request] binary value from [decoder] *)

val decode_pb_signal_update_seeked : Pbrt.Decoder.t -> signal_update_seeked
(** [decode_pb_signal_update_seeked decoder] decodes a [signal_update_seeked] binary value from [decoder] *)

val decode_pb_signal_update : Pbrt.Decoder.t -> signal_update
(** [decode_pb_signal_update decoder] decodes a [signal_update] binary value from [decoder] *)

val decode_pb_fetch_property_request : Pbrt.Decoder.t -> fetch_property_request
(** [decode_pb_fetch_property_request decoder] decodes a [fetch_property_request] binary value from [decoder] *)

val decode_pb_update : Pbrt.Decoder.t -> update
(** [decode_pb_update decoder] decodes a [update] binary value from [decoder] *)

val decode_pb_open_uri_request : Pbrt.Decoder.t -> open_uri_request
(** [decode_pb_open_uri_request decoder] decodes a [open_uri_request] binary value from [decoder] *)

val decode_pb_seek_request : Pbrt.Decoder.t -> seek_request
(** [decode_pb_seek_request decoder] decodes a [seek_request] binary value from [decoder] *)

val decode_pb_set_position_request : Pbrt.Decoder.t -> set_position_request
(** [decode_pb_set_position_request decoder] decodes a [set_position_request] binary value from [decoder] *)

val decode_pb_rpc_call : Pbrt.Decoder.t -> rpc_call
(** [decode_pb_rpc_call decoder] decodes a [rpc_call] binary value from [decoder] *)

val decode_pb_rpc_response : Pbrt.Decoder.t -> rpc_response
(** [decode_pb_rpc_response decoder] decodes a [rpc_response] binary value from [decoder] *)


(** {2 Protobuf YoJson Encoding} *)

val encode_json_empty : empty -> Yojson.Basic.t
(** [encode_json_empty v encoder] encodes [v] to to json *)

val encode_json_loop_status : loop_status -> Yojson.Basic.t
(** [encode_json_loop_status v encoder] encodes [v] to to json *)

val encode_json_property : property -> Yojson.Basic.t
(** [encode_json_property v encoder] encodes [v] to to json *)

val encode_json_loop_status_optional : loop_status_optional -> Yojson.Basic.t
(** [encode_json_loop_status_optional v encoder] encodes [v] to to json *)

val encode_json_shuffle_optional : shuffle_optional -> Yojson.Basic.t
(** [encode_json_shuffle_optional v encoder] encodes [v] to to json *)

val encode_json_property_update_playback_status : property_update_playback_status -> Yojson.Basic.t
(** [encode_json_property_update_playback_status v encoder] encodes [v] to to json *)

val encode_json_property_update_metadata : property_update_metadata -> Yojson.Basic.t
(** [encode_json_property_update_metadata v encoder] encodes [v] to to json *)

val encode_json_property_update : property_update -> Yojson.Basic.t
(** [encode_json_property_update v encoder] encodes [v] to to json *)

val encode_json_set_loop_status_request : set_loop_status_request -> Yojson.Basic.t
(** [encode_json_set_loop_status_request v encoder] encodes [v] to to json *)

val encode_json_set_rate_request : set_rate_request -> Yojson.Basic.t
(** [encode_json_set_rate_request v encoder] encodes [v] to to json *)

val encode_json_set_shuffle_request : set_shuffle_request -> Yojson.Basic.t
(** [encode_json_set_shuffle_request v encoder] encodes [v] to to json *)

val encode_json_set_volume_request : set_volume_request -> Yojson.Basic.t
(** [encode_json_set_volume_request v encoder] encodes [v] to to json *)

val encode_json_signal_update_seeked : signal_update_seeked -> Yojson.Basic.t
(** [encode_json_signal_update_seeked v encoder] encodes [v] to to json *)

val encode_json_signal_update : signal_update -> Yojson.Basic.t
(** [encode_json_signal_update v encoder] encodes [v] to to json *)

val encode_json_fetch_property_request : fetch_property_request -> Yojson.Basic.t
(** [encode_json_fetch_property_request v encoder] encodes [v] to to json *)

val encode_json_update : update -> Yojson.Basic.t
(** [encode_json_update v encoder] encodes [v] to to json *)

val encode_json_open_uri_request : open_uri_request -> Yojson.Basic.t
(** [encode_json_open_uri_request v encoder] encodes [v] to to json *)

val encode_json_seek_request : seek_request -> Yojson.Basic.t
(** [encode_json_seek_request v encoder] encodes [v] to to json *)

val encode_json_set_position_request : set_position_request -> Yojson.Basic.t
(** [encode_json_set_position_request v encoder] encodes [v] to to json *)

val encode_json_rpc_call : rpc_call -> Yojson.Basic.t
(** [encode_json_rpc_call v encoder] encodes [v] to to json *)

val encode_json_rpc_response : rpc_response -> Yojson.Basic.t
(** [encode_json_rpc_response v encoder] encodes [v] to to json *)


(** {2 JSON Decoding} *)

val decode_json_empty : Yojson.Basic.t -> empty
(** [decode_json_empty decoder] decodes a [empty] value from [decoder] *)

val decode_json_loop_status : Yojson.Basic.t -> loop_status
(** [decode_json_loop_status decoder] decodes a [loop_status] value from [decoder] *)

val decode_json_property : Yojson.Basic.t -> property
(** [decode_json_property decoder] decodes a [property] value from [decoder] *)

val decode_json_loop_status_optional : Yojson.Basic.t -> loop_status_optional
(** [decode_json_loop_status_optional decoder] decodes a [loop_status_optional] value from [decoder] *)

val decode_json_shuffle_optional : Yojson.Basic.t -> shuffle_optional
(** [decode_json_shuffle_optional decoder] decodes a [shuffle_optional] value from [decoder] *)

val decode_json_property_update_playback_status : Yojson.Basic.t -> property_update_playback_status
(** [decode_json_property_update_playback_status decoder] decodes a [property_update_playback_status] value from [decoder] *)

val decode_json_property_update_metadata : Yojson.Basic.t -> property_update_metadata
(** [decode_json_property_update_metadata decoder] decodes a [property_update_metadata] value from [decoder] *)

val decode_json_property_update : Yojson.Basic.t -> property_update
(** [decode_json_property_update decoder] decodes a [property_update] value from [decoder] *)

val decode_json_set_loop_status_request : Yojson.Basic.t -> set_loop_status_request
(** [decode_json_set_loop_status_request decoder] decodes a [set_loop_status_request] value from [decoder] *)

val decode_json_set_rate_request : Yojson.Basic.t -> set_rate_request
(** [decode_json_set_rate_request decoder] decodes a [set_rate_request] value from [decoder] *)

val decode_json_set_shuffle_request : Yojson.Basic.t -> set_shuffle_request
(** [decode_json_set_shuffle_request decoder] decodes a [set_shuffle_request] value from [decoder] *)

val decode_json_set_volume_request : Yojson.Basic.t -> set_volume_request
(** [decode_json_set_volume_request decoder] decodes a [set_volume_request] value from [decoder] *)

val decode_json_signal_update_seeked : Yojson.Basic.t -> signal_update_seeked
(** [decode_json_signal_update_seeked decoder] decodes a [signal_update_seeked] value from [decoder] *)

val decode_json_signal_update : Yojson.Basic.t -> signal_update
(** [decode_json_signal_update decoder] decodes a [signal_update] value from [decoder] *)

val decode_json_fetch_property_request : Yojson.Basic.t -> fetch_property_request
(** [decode_json_fetch_property_request decoder] decodes a [fetch_property_request] value from [decoder] *)

val decode_json_update : Yojson.Basic.t -> update
(** [decode_json_update decoder] decodes a [update] value from [decoder] *)

val decode_json_open_uri_request : Yojson.Basic.t -> open_uri_request
(** [decode_json_open_uri_request decoder] decodes a [open_uri_request] value from [decoder] *)

val decode_json_seek_request : Yojson.Basic.t -> seek_request
(** [decode_json_seek_request decoder] decodes a [seek_request] value from [decoder] *)

val decode_json_set_position_request : Yojson.Basic.t -> set_position_request
(** [decode_json_set_position_request decoder] decodes a [set_position_request] value from [decoder] *)

val decode_json_rpc_call : Yojson.Basic.t -> rpc_call
(** [decode_json_rpc_call decoder] decodes a [rpc_call] value from [decoder] *)

val decode_json_rpc_response : Yojson.Basic.t -> rpc_response
(** [decode_json_rpc_response decoder] decodes a [rpc_response] value from [decoder] *)


(** {2 Services} *)

(** MPRIS service *)
module MPRIS : sig
  open Pbrt_services
  open Pbrt_services.Value_mode
  
  module Client : sig
    
    val fetchProperty : (fetch_property_request, unary, property_update, unary) Client.rpc
    
    val subscribe : (unit, unary, update, stream) Client.rpc
    
    val next : (unit, unary, unit, unary) Client.rpc
    
    val openUri : (open_uri_request, unary, unit, unary) Client.rpc
    
    val pause : (unit, unary, unit, unary) Client.rpc
    
    val play : (unit, unary, unit, unary) Client.rpc
    
    val playPause : (unit, unary, unit, unary) Client.rpc
    
    val previous : (unit, unary, unit, unary) Client.rpc
    
    val seek : (seek_request, unary, unit, unary) Client.rpc
    
    val setPosition : (set_position_request, unary, unit, unary) Client.rpc
    
    val stop : (unit, unary, unit, unary) Client.rpc
    
    val setLoopStatus : (set_loop_status_request, unary, unit, unary) Client.rpc
    
    val setRate : (set_rate_request, unary, unit, unary) Client.rpc
    
    val setShuffle : (set_shuffle_request, unary, unit, unary) Client.rpc
    
    val setVolume : (set_volume_request, unary, unit, unary) Client.rpc
    
    val ping : (unit, unary, unit, unary) Client.rpc
  end
  
  module Server : sig
    (** Produce a server implementation from handlers *)
    val make : 
      fetchProperty:((fetch_property_request, unary, property_update, unary) Server.rpc -> 'handler) ->
      subscribe:((unit, unary, update, stream) Server.rpc -> 'handler) ->
      next:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      openUri:((open_uri_request, unary, unit, unary) Server.rpc -> 'handler) ->
      pause:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      play:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      playPause:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      previous:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      seek:((seek_request, unary, unit, unary) Server.rpc -> 'handler) ->
      setPosition:((set_position_request, unary, unit, unary) Server.rpc -> 'handler) ->
      stop:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      setLoopStatus:((set_loop_status_request, unary, unit, unary) Server.rpc -> 'handler) ->
      setRate:((set_rate_request, unary, unit, unary) Server.rpc -> 'handler) ->
      setShuffle:((set_shuffle_request, unary, unit, unary) Server.rpc -> 'handler) ->
      setVolume:((set_volume_request, unary, unit, unary) Server.rpc -> 'handler) ->
      ping:((unit, unary, unit, unary) Server.rpc -> 'handler) ->
      unit -> 'handler Pbrt_services.Server.t
  end
end
