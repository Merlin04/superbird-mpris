[@@@ocaml.warning "-27-30-39"]

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
  use_count : int32 option;
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

let rec default_empty = ()

let rec default_loop_status () = (Loop_status_none:loop_status)

let rec default_property () = (Property_can_control:property)

let rec default_loop_status_optional (): loop_status_optional = None

let rec default_shuffle_optional (): shuffle_optional = None

let rec default_property_update_playback_status () = (Playback_status_playing:property_update_playback_status)

let rec default_property_update_metadata 
  ?o_mpris_trackid:((o_mpris_trackid:string) = "")
  ?mpris_length:((mpris_length:int64 option) = None)
  ?mpris_art_url_bytes:((mpris_art_url_bytes:bytes option) = None)
  ?xesam_album:((xesam_album:string option) = None)
  ?xesam_album_artist:((xesam_album_artist:string list) = [])
  ?xesam_artist:((xesam_artist:string list) = [])
  ?xesam_as_text:((xesam_as_text:string option) = None)
  ?xesam_audio_bpm:((xesam_audio_bpm:int32 option) = None)
  ?xesam_auto_rating:((xesam_auto_rating:float option) = None)
  ?xesam_comment:((xesam_comment:string list) = [])
  ?xesam_composer:((xesam_composer:string list) = [])
  ?d_xesam_content_created:((d_xesam_content_created:string option) = None)
  ?xesam_disc_number:((xesam_disc_number:int32 option) = None)
  ?d_xesam_first_used:((d_xesam_first_used:string option) = None)
  ?xesam_genre:((xesam_genre:string list) = [])
  ?d_xesam_last_used:((d_xesam_last_used:string option) = None)
  ?xesam_lyricist:((xesam_lyricist:string list) = [])
  ?xesam_title:((xesam_title:string option) = None)
  ?xesam_track_number:((xesam_track_number:int32 option) = None)
  ?xesam_url:((xesam_url:string option) = None)
  ?use_count:((use_count:int32 option) = None)
  ?xesam_user_rating:((xesam_user_rating:float option) = None)
  () : property_update_metadata  = {
  o_mpris_trackid;
  mpris_length;
  mpris_art_url_bytes;
  xesam_album;
  xesam_album_artist;
  xesam_artist;
  xesam_as_text;
  xesam_audio_bpm;
  xesam_auto_rating;
  xesam_comment;
  xesam_composer;
  d_xesam_content_created;
  xesam_disc_number;
  d_xesam_first_used;
  xesam_genre;
  d_xesam_last_used;
  xesam_lyricist;
  xesam_title;
  xesam_track_number;
  xesam_url;
  use_count;
  xesam_user_rating;
}

let rec default_property_update () : property_update = Can_control (false)

let rec default_set_loop_status_request 
  ?loop_status:((loop_status:loop_status) = default_loop_status ())
  () : set_loop_status_request  = {
  loop_status;
}

let rec default_set_rate_request 
  ?rate:((rate:float) = 0.)
  () : set_rate_request  = {
  rate;
}

let rec default_set_shuffle_request 
  ?shuffle:((shuffle:bool) = false)
  () : set_shuffle_request  = {
  shuffle;
}

let rec default_set_volume_request 
  ?volume:((volume:float) = 0.)
  () : set_volume_request  = {
  volume;
}

let rec default_signal_update_seeked 
  ?position:((position:int64) = 0L)
  () : signal_update_seeked  = {
  position;
}

let rec default_signal_update () : signal_update = Seeked (default_signal_update_seeked ())

let rec default_fetch_property_request 
  ?property:((property:property) = default_property ())
  () : fetch_property_request  = {
  property;
}

let rec default_update () : update = Property (default_property_update ())

let rec default_open_uri_request 
  ?uri:((uri:string) = "")
  () : open_uri_request  = {
  uri;
}

let rec default_seek_request 
  ?offset:((offset:int64) = 0L)
  () : seek_request  = {
  offset;
}

let rec default_set_position_request 
  ?o_track_id:((o_track_id:string) = "")
  ?offset:((offset:int64) = 0L)
  () : set_position_request  = {
  o_track_id;
  offset;
}

let rec default_rpc_call 
  ?call_id:((call_id:int64) = 0L)
  ?name:((name:string) = "")
  ?req:((req:bytes) = Bytes.create 0)
  () : rpc_call  = {
  call_id;
  name;
  req;
}

let rec default_rpc_response 
  ?call_id:((call_id:int64) = 0L)
  ?res:((res:bytes option) = None)
  () : rpc_response  = {
  call_id;
  res;
}

type property_update_metadata_mutable = {
  mutable o_mpris_trackid : string;
  mutable mpris_length : int64 option;
  mutable mpris_art_url_bytes : bytes option;
  mutable xesam_album : string option;
  mutable xesam_album_artist : string list;
  mutable xesam_artist : string list;
  mutable xesam_as_text : string option;
  mutable xesam_audio_bpm : int32 option;
  mutable xesam_auto_rating : float option;
  mutable xesam_comment : string list;
  mutable xesam_composer : string list;
  mutable d_xesam_content_created : string option;
  mutable xesam_disc_number : int32 option;
  mutable d_xesam_first_used : string option;
  mutable xesam_genre : string list;
  mutable d_xesam_last_used : string option;
  mutable xesam_lyricist : string list;
  mutable xesam_title : string option;
  mutable xesam_track_number : int32 option;
  mutable xesam_url : string option;
  mutable use_count : int32 option;
  mutable xesam_user_rating : float option;
}

let default_property_update_metadata_mutable () : property_update_metadata_mutable = {
  o_mpris_trackid = "";
  mpris_length = None;
  mpris_art_url_bytes = None;
  xesam_album = None;
  xesam_album_artist = [];
  xesam_artist = [];
  xesam_as_text = None;
  xesam_audio_bpm = None;
  xesam_auto_rating = None;
  xesam_comment = [];
  xesam_composer = [];
  d_xesam_content_created = None;
  xesam_disc_number = None;
  d_xesam_first_used = None;
  xesam_genre = [];
  d_xesam_last_used = None;
  xesam_lyricist = [];
  xesam_title = None;
  xesam_track_number = None;
  xesam_url = None;
  use_count = None;
  xesam_user_rating = None;
}

type set_loop_status_request_mutable = {
  mutable loop_status : loop_status;
}

let default_set_loop_status_request_mutable () : set_loop_status_request_mutable = {
  loop_status = default_loop_status ();
}

type set_rate_request_mutable = {
  mutable rate : float;
}

let default_set_rate_request_mutable () : set_rate_request_mutable = {
  rate = 0.;
}

type set_shuffle_request_mutable = {
  mutable shuffle : bool;
}

let default_set_shuffle_request_mutable () : set_shuffle_request_mutable = {
  shuffle = false;
}

type set_volume_request_mutable = {
  mutable volume : float;
}

let default_set_volume_request_mutable () : set_volume_request_mutable = {
  volume = 0.;
}

type signal_update_seeked_mutable = {
  mutable position : int64;
}

let default_signal_update_seeked_mutable () : signal_update_seeked_mutable = {
  position = 0L;
}

type fetch_property_request_mutable = {
  mutable property : property;
}

let default_fetch_property_request_mutable () : fetch_property_request_mutable = {
  property = default_property ();
}

type open_uri_request_mutable = {
  mutable uri : string;
}

let default_open_uri_request_mutable () : open_uri_request_mutable = {
  uri = "";
}

type seek_request_mutable = {
  mutable offset : int64;
}

let default_seek_request_mutable () : seek_request_mutable = {
  offset = 0L;
}

type set_position_request_mutable = {
  mutable o_track_id : string;
  mutable offset : int64;
}

let default_set_position_request_mutable () : set_position_request_mutable = {
  o_track_id = "";
  offset = 0L;
}

type rpc_call_mutable = {
  mutable call_id : int64;
  mutable name : string;
  mutable req : bytes;
}

let default_rpc_call_mutable () : rpc_call_mutable = {
  call_id = 0L;
  name = "";
  req = Bytes.create 0;
}

type rpc_response_mutable = {
  mutable call_id : int64;
  mutable res : bytes option;
}

let default_rpc_response_mutable () : rpc_response_mutable = {
  call_id = 0L;
  res = None;
}

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Encoding} *)

let rec encode_pb_empty (v:empty) encoder = 
()

let rec encode_pb_loop_status (v:loop_status) encoder =
  match v with
  | Loop_status_none -> Pbrt.Encoder.int_as_varint (0) encoder
  | Loop_status_track -> Pbrt.Encoder.int_as_varint 1 encoder
  | Loop_status_playlist -> Pbrt.Encoder.int_as_varint 2 encoder

let rec encode_pb_property (v:property) encoder =
  match v with
  | Property_can_control -> Pbrt.Encoder.int_as_varint (0) encoder
  | Property_can_go_next -> Pbrt.Encoder.int_as_varint 1 encoder
  | Property_can_go_previous -> Pbrt.Encoder.int_as_varint 2 encoder
  | Property_can_pause -> Pbrt.Encoder.int_as_varint 3 encoder
  | Property_can_play -> Pbrt.Encoder.int_as_varint 4 encoder
  | Property_can_seek -> Pbrt.Encoder.int_as_varint 5 encoder
  | Property_loop_status -> Pbrt.Encoder.int_as_varint 6 encoder
  | Property_maximum_rate -> Pbrt.Encoder.int_as_varint 7 encoder
  | Property_metadata -> Pbrt.Encoder.int_as_varint 8 encoder
  | Property_minimum_rate -> Pbrt.Encoder.int_as_varint 9 encoder
  | Property_playback_status -> Pbrt.Encoder.int_as_varint 10 encoder
  | Property_position -> Pbrt.Encoder.int_as_varint 11 encoder
  | Property_rate -> Pbrt.Encoder.int_as_varint 12 encoder
  | Property_shuffle -> Pbrt.Encoder.int_as_varint 13 encoder
  | Property_volume -> Pbrt.Encoder.int_as_varint 14 encoder

let rec encode_pb_loop_status_optional (v:loop_status_optional) encoder = 
  begin match v with
  | None ->
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
    Pbrt.Encoder.empty_nested encoder
  | Value x ->
    encode_pb_loop_status x encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  end

let rec encode_pb_shuffle_optional (v:shuffle_optional) encoder = 
  begin match v with
  | None ->
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
    Pbrt.Encoder.empty_nested encoder
  | Value x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  end

let rec encode_pb_property_update_playback_status (v:property_update_playback_status) encoder =
  match v with
  | Playback_status_playing -> Pbrt.Encoder.int_as_varint (0) encoder
  | Playback_status_paused -> Pbrt.Encoder.int_as_varint 1 encoder
  | Playback_status_stopped -> Pbrt.Encoder.int_as_varint 2 encoder

let rec encode_pb_property_update_metadata (v:property_update_metadata) encoder = 
  Pbrt.Encoder.string v.o_mpris_trackid encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  begin match v.mpris_length with
  | Some x -> 
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.mpris_art_url_bytes with
  | Some x -> 
    Pbrt.Encoder.bytes x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.xesam_album with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 4 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 5 Pbrt.Bytes encoder; 
  ) v.xesam_album_artist encoder;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 6 Pbrt.Bytes encoder; 
  ) v.xesam_artist encoder;
  begin match v.xesam_as_text with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 7 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.xesam_audio_bpm with
  | Some x -> 
    Pbrt.Encoder.int32_as_varint x encoder;
    Pbrt.Encoder.key 8 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.xesam_auto_rating with
  | Some x -> 
    Pbrt.Encoder.float_as_bits32 x encoder;
    Pbrt.Encoder.key 9 Pbrt.Bits32 encoder; 
  | None -> ();
  end;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 10 Pbrt.Bytes encoder; 
  ) v.xesam_comment encoder;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 11 Pbrt.Bytes encoder; 
  ) v.xesam_composer encoder;
  begin match v.d_xesam_content_created with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 12 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.xesam_disc_number with
  | Some x -> 
    Pbrt.Encoder.int32_as_varint x encoder;
    Pbrt.Encoder.key 13 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.d_xesam_first_used with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 14 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 15 Pbrt.Bytes encoder; 
  ) v.xesam_genre encoder;
  begin match v.d_xesam_last_used with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 16 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 17 Pbrt.Bytes encoder; 
  ) v.xesam_lyricist encoder;
  begin match v.xesam_title with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 18 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.xesam_track_number with
  | Some x -> 
    Pbrt.Encoder.int32_as_varint x encoder;
    Pbrt.Encoder.key 19 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.xesam_url with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 20 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.use_count with
  | Some x -> 
    Pbrt.Encoder.int32_as_varint x encoder;
    Pbrt.Encoder.key 21 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.xesam_user_rating with
  | Some x -> 
    Pbrt.Encoder.float_as_bits32 x encoder;
    Pbrt.Encoder.key 22 Pbrt.Bits32 encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_property_update (v:property_update) encoder = 
  begin match v with
  | Can_control x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  | Can_go_next x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  | Can_go_previous x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  | Can_pause x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  | Can_play x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  | Can_seek x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 6 Pbrt.Varint encoder; 
  | Loop_status x ->
    Pbrt.Encoder.nested encode_pb_loop_status_optional x encoder;
    Pbrt.Encoder.key 7 Pbrt.Bytes encoder; 
  | Maximum_rate x ->
    Pbrt.Encoder.float_as_bits64 x encoder;
    Pbrt.Encoder.key 8 Pbrt.Bits64 encoder; 
  | Metadata x ->
    Pbrt.Encoder.nested encode_pb_property_update_metadata x encoder;
    Pbrt.Encoder.key 9 Pbrt.Bytes encoder; 
  | Minimum_rate x ->
    Pbrt.Encoder.float_as_bits64 x encoder;
    Pbrt.Encoder.key 10 Pbrt.Bits64 encoder; 
  | Playback_status x ->
    encode_pb_property_update_playback_status x encoder;
    Pbrt.Encoder.key 11 Pbrt.Varint encoder; 
  | Position x ->
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 12 Pbrt.Varint encoder; 
  | Rate x ->
    Pbrt.Encoder.float_as_bits64 x encoder;
    Pbrt.Encoder.key 13 Pbrt.Bits64 encoder; 
  | Shuffle x ->
    Pbrt.Encoder.nested encode_pb_shuffle_optional x encoder;
    Pbrt.Encoder.key 14 Pbrt.Bytes encoder; 
  | Volume x ->
    Pbrt.Encoder.float_as_bits64 x encoder;
    Pbrt.Encoder.key 15 Pbrt.Bits64 encoder; 
  end

let rec encode_pb_set_loop_status_request (v:set_loop_status_request) encoder = 
  encode_pb_loop_status v.loop_status encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  ()

let rec encode_pb_set_rate_request (v:set_rate_request) encoder = 
  Pbrt.Encoder.float_as_bits64 v.rate encoder;
  Pbrt.Encoder.key 1 Pbrt.Bits64 encoder; 
  ()

let rec encode_pb_set_shuffle_request (v:set_shuffle_request) encoder = 
  Pbrt.Encoder.bool v.shuffle encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  ()

let rec encode_pb_set_volume_request (v:set_volume_request) encoder = 
  Pbrt.Encoder.float_as_bits64 v.volume encoder;
  Pbrt.Encoder.key 1 Pbrt.Bits64 encoder; 
  ()

let rec encode_pb_signal_update_seeked (v:signal_update_seeked) encoder = 
  Pbrt.Encoder.int64_as_varint v.position encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  ()

let rec encode_pb_signal_update (v:signal_update) encoder = 
  begin match v with
  | Seeked x ->
    Pbrt.Encoder.nested encode_pb_signal_update_seeked x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  end

let rec encode_pb_fetch_property_request (v:fetch_property_request) encoder = 
  encode_pb_property v.property encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  ()

let rec encode_pb_update (v:update) encoder = 
  begin match v with
  | Property x ->
    Pbrt.Encoder.nested encode_pb_property_update x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  | Signal x ->
    Pbrt.Encoder.nested encode_pb_signal_update x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  end

let rec encode_pb_open_uri_request (v:open_uri_request) encoder = 
  Pbrt.Encoder.string v.uri encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  ()

let rec encode_pb_seek_request (v:seek_request) encoder = 
  Pbrt.Encoder.int64_as_varint v.offset encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  ()

let rec encode_pb_set_position_request (v:set_position_request) encoder = 
  Pbrt.Encoder.string v.o_track_id encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  Pbrt.Encoder.int64_as_varint v.offset encoder;
  Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  ()

let rec encode_pb_rpc_call (v:rpc_call) encoder = 
  Pbrt.Encoder.int64_as_varint v.call_id encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.string v.name encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  Pbrt.Encoder.bytes v.req encoder;
  Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  ()

let rec encode_pb_rpc_response (v:rpc_response) encoder = 
  Pbrt.Encoder.int64_as_varint v.call_id encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  begin match v.res with
  | Some x -> 
    Pbrt.Encoder.bytes x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Decoding} *)

let rec decode_pb_empty d =
  match Pbrt.Decoder.key d with
  | None -> ();
  | Some (_, pk) -> 
    Pbrt.Decoder.unexpected_payload "Unexpected fields in empty message(empty)" pk

let rec decode_pb_loop_status d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Loop_status_none:loop_status)
  | 1 -> (Loop_status_track:loop_status)
  | 2 -> (Loop_status_playlist:loop_status)
  | _ -> Pbrt.Decoder.malformed_variant "loop_status"

let rec decode_pb_property d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Property_can_control:property)
  | 1 -> (Property_can_go_next:property)
  | 2 -> (Property_can_go_previous:property)
  | 3 -> (Property_can_pause:property)
  | 4 -> (Property_can_play:property)
  | 5 -> (Property_can_seek:property)
  | 6 -> (Property_loop_status:property)
  | 7 -> (Property_maximum_rate:property)
  | 8 -> (Property_metadata:property)
  | 9 -> (Property_minimum_rate:property)
  | 10 -> (Property_playback_status:property)
  | 11 -> (Property_position:property)
  | 12 -> (Property_rate:property)
  | 13 -> (Property_shuffle:property)
  | 14 -> (Property_volume:property)
  | _ -> Pbrt.Decoder.malformed_variant "property"

let rec decode_pb_loop_status_optional d = 
  let rec loop () = 
    let ret:loop_status_optional = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "loop_status_optional"
      | Some (1, _) -> begin 
        Pbrt.Decoder.empty_nested d ;
        (None : loop_status_optional)
      end
      | Some (2, _) -> (Value (decode_pb_loop_status d) : loop_status_optional) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_shuffle_optional d = 
  let rec loop () = 
    let ret:shuffle_optional = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "shuffle_optional"
      | Some (1, _) -> begin 
        Pbrt.Decoder.empty_nested d ;
        (None : shuffle_optional)
      end
      | Some (2, _) -> (Value (Pbrt.Decoder.bool d) : shuffle_optional) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_property_update_playback_status d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Playback_status_playing:property_update_playback_status)
  | 1 -> (Playback_status_paused:property_update_playback_status)
  | 2 -> (Playback_status_stopped:property_update_playback_status)
  | _ -> Pbrt.Decoder.malformed_variant "property_update_playback_status"

let rec decode_pb_property_update_metadata d =
  let v = default_property_update_metadata_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      v.xesam_lyricist <- List.rev v.xesam_lyricist;
      v.xesam_genre <- List.rev v.xesam_genre;
      v.xesam_composer <- List.rev v.xesam_composer;
      v.xesam_comment <- List.rev v.xesam_comment;
      v.xesam_artist <- List.rev v.xesam_artist;
      v.xesam_album_artist <- List.rev v.xesam_album_artist;
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.o_mpris_trackid <- Pbrt.Decoder.string d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(1)" pk
    | Some (2, Pbrt.Varint) -> begin
      v.mpris_length <- Some (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.mpris_art_url_bytes <- Some (Pbrt.Decoder.bytes d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(3)" pk
    | Some (4, Pbrt.Bytes) -> begin
      v.xesam_album <- Some (Pbrt.Decoder.string d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(4)" pk
    | Some (5, Pbrt.Bytes) -> begin
      v.xesam_album_artist <- (Pbrt.Decoder.string d) :: v.xesam_album_artist;
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(5)" pk
    | Some (6, Pbrt.Bytes) -> begin
      v.xesam_artist <- (Pbrt.Decoder.string d) :: v.xesam_artist;
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(6)" pk
    | Some (7, Pbrt.Bytes) -> begin
      v.xesam_as_text <- Some (Pbrt.Decoder.string d);
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(7)" pk
    | Some (8, Pbrt.Varint) -> begin
      v.xesam_audio_bpm <- Some (Pbrt.Decoder.int32_as_varint d);
    end
    | Some (8, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(8)" pk
    | Some (9, Pbrt.Bits32) -> begin
      v.xesam_auto_rating <- Some (Pbrt.Decoder.float_as_bits32 d);
    end
    | Some (9, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(9)" pk
    | Some (10, Pbrt.Bytes) -> begin
      v.xesam_comment <- (Pbrt.Decoder.string d) :: v.xesam_comment;
    end
    | Some (10, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(10)" pk
    | Some (11, Pbrt.Bytes) -> begin
      v.xesam_composer <- (Pbrt.Decoder.string d) :: v.xesam_composer;
    end
    | Some (11, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(11)" pk
    | Some (12, Pbrt.Bytes) -> begin
      v.d_xesam_content_created <- Some (Pbrt.Decoder.string d);
    end
    | Some (12, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(12)" pk
    | Some (13, Pbrt.Varint) -> begin
      v.xesam_disc_number <- Some (Pbrt.Decoder.int32_as_varint d);
    end
    | Some (13, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(13)" pk
    | Some (14, Pbrt.Bytes) -> begin
      v.d_xesam_first_used <- Some (Pbrt.Decoder.string d);
    end
    | Some (14, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(14)" pk
    | Some (15, Pbrt.Bytes) -> begin
      v.xesam_genre <- (Pbrt.Decoder.string d) :: v.xesam_genre;
    end
    | Some (15, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(15)" pk
    | Some (16, Pbrt.Bytes) -> begin
      v.d_xesam_last_used <- Some (Pbrt.Decoder.string d);
    end
    | Some (16, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(16)" pk
    | Some (17, Pbrt.Bytes) -> begin
      v.xesam_lyricist <- (Pbrt.Decoder.string d) :: v.xesam_lyricist;
    end
    | Some (17, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(17)" pk
    | Some (18, Pbrt.Bytes) -> begin
      v.xesam_title <- Some (Pbrt.Decoder.string d);
    end
    | Some (18, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(18)" pk
    | Some (19, Pbrt.Varint) -> begin
      v.xesam_track_number <- Some (Pbrt.Decoder.int32_as_varint d);
    end
    | Some (19, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(19)" pk
    | Some (20, Pbrt.Bytes) -> begin
      v.xesam_url <- Some (Pbrt.Decoder.string d);
    end
    | Some (20, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(20)" pk
    | Some (21, Pbrt.Varint) -> begin
      v.use_count <- Some (Pbrt.Decoder.int32_as_varint d);
    end
    | Some (21, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(21)" pk
    | Some (22, Pbrt.Bits32) -> begin
      v.xesam_user_rating <- Some (Pbrt.Decoder.float_as_bits32 d);
    end
    | Some (22, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(property_update_metadata), field(22)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    o_mpris_trackid = v.o_mpris_trackid;
    mpris_length = v.mpris_length;
    mpris_art_url_bytes = v.mpris_art_url_bytes;
    xesam_album = v.xesam_album;
    xesam_album_artist = v.xesam_album_artist;
    xesam_artist = v.xesam_artist;
    xesam_as_text = v.xesam_as_text;
    xesam_audio_bpm = v.xesam_audio_bpm;
    xesam_auto_rating = v.xesam_auto_rating;
    xesam_comment = v.xesam_comment;
    xesam_composer = v.xesam_composer;
    d_xesam_content_created = v.d_xesam_content_created;
    xesam_disc_number = v.xesam_disc_number;
    d_xesam_first_used = v.d_xesam_first_used;
    xesam_genre = v.xesam_genre;
    d_xesam_last_used = v.d_xesam_last_used;
    xesam_lyricist = v.xesam_lyricist;
    xesam_title = v.xesam_title;
    xesam_track_number = v.xesam_track_number;
    xesam_url = v.xesam_url;
    use_count = v.use_count;
    xesam_user_rating = v.xesam_user_rating;
  } : property_update_metadata)

let rec decode_pb_property_update d = 
  let rec loop () = 
    let ret:property_update = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "property_update"
      | Some (1, _) -> (Can_control (Pbrt.Decoder.bool d) : property_update) 
      | Some (2, _) -> (Can_go_next (Pbrt.Decoder.bool d) : property_update) 
      | Some (3, _) -> (Can_go_previous (Pbrt.Decoder.bool d) : property_update) 
      | Some (4, _) -> (Can_pause (Pbrt.Decoder.bool d) : property_update) 
      | Some (5, _) -> (Can_play (Pbrt.Decoder.bool d) : property_update) 
      | Some (6, _) -> (Can_seek (Pbrt.Decoder.bool d) : property_update) 
      | Some (7, _) -> (Loop_status (decode_pb_loop_status_optional (Pbrt.Decoder.nested d)) : property_update) 
      | Some (8, _) -> (Maximum_rate (Pbrt.Decoder.float_as_bits64 d) : property_update) 
      | Some (9, _) -> (Metadata (decode_pb_property_update_metadata (Pbrt.Decoder.nested d)) : property_update) 
      | Some (10, _) -> (Minimum_rate (Pbrt.Decoder.float_as_bits64 d) : property_update) 
      | Some (11, _) -> (Playback_status (decode_pb_property_update_playback_status d) : property_update) 
      | Some (12, _) -> (Position (Pbrt.Decoder.int64_as_varint d) : property_update) 
      | Some (13, _) -> (Rate (Pbrt.Decoder.float_as_bits64 d) : property_update) 
      | Some (14, _) -> (Shuffle (decode_pb_shuffle_optional (Pbrt.Decoder.nested d)) : property_update) 
      | Some (15, _) -> (Volume (Pbrt.Decoder.float_as_bits64 d) : property_update) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_set_loop_status_request d =
  let v = default_set_loop_status_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.loop_status <- decode_pb_loop_status d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_loop_status_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    loop_status = v.loop_status;
  } : set_loop_status_request)

let rec decode_pb_set_rate_request d =
  let v = default_set_rate_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bits64) -> begin
      v.rate <- Pbrt.Decoder.float_as_bits64 d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_rate_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    rate = v.rate;
  } : set_rate_request)

let rec decode_pb_set_shuffle_request d =
  let v = default_set_shuffle_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.shuffle <- Pbrt.Decoder.bool d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_shuffle_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    shuffle = v.shuffle;
  } : set_shuffle_request)

let rec decode_pb_set_volume_request d =
  let v = default_set_volume_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bits64) -> begin
      v.volume <- Pbrt.Decoder.float_as_bits64 d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_volume_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    volume = v.volume;
  } : set_volume_request)

let rec decode_pb_signal_update_seeked d =
  let v = default_signal_update_seeked_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.position <- Pbrt.Decoder.int64_as_varint d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(signal_update_seeked), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    position = v.position;
  } : signal_update_seeked)

let rec decode_pb_signal_update d = 
  let rec loop () = 
    let ret:signal_update = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "signal_update"
      | Some (1, _) -> (Seeked (decode_pb_signal_update_seeked (Pbrt.Decoder.nested d)) : signal_update) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_fetch_property_request d =
  let v = default_fetch_property_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.property <- decode_pb_property d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(fetch_property_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    property = v.property;
  } : fetch_property_request)

let rec decode_pb_update d = 
  let rec loop () = 
    let ret:update = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "update"
      | Some (1, _) -> (Property (decode_pb_property_update (Pbrt.Decoder.nested d)) : update) 
      | Some (2, _) -> (Signal (decode_pb_signal_update (Pbrt.Decoder.nested d)) : update) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_open_uri_request d =
  let v = default_open_uri_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.uri <- Pbrt.Decoder.string d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(open_uri_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    uri = v.uri;
  } : open_uri_request)

let rec decode_pb_seek_request d =
  let v = default_seek_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.offset <- Pbrt.Decoder.int64_as_varint d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(seek_request), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    offset = v.offset;
  } : seek_request)

let rec decode_pb_set_position_request d =
  let v = default_set_position_request_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.o_track_id <- Pbrt.Decoder.string d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_position_request), field(1)" pk
    | Some (2, Pbrt.Varint) -> begin
      v.offset <- Pbrt.Decoder.int64_as_varint d;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(set_position_request), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    o_track_id = v.o_track_id;
    offset = v.offset;
  } : set_position_request)

let rec decode_pb_rpc_call d =
  let v = default_rpc_call_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.call_id <- Pbrt.Decoder.int64_as_varint d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(rpc_call), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.name <- Pbrt.Decoder.string d;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(rpc_call), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.req <- Pbrt.Decoder.bytes d;
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(rpc_call), field(3)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    call_id = v.call_id;
    name = v.name;
    req = v.req;
  } : rpc_call)

let rec decode_pb_rpc_response d =
  let v = default_rpc_response_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.call_id <- Pbrt.Decoder.int64_as_varint d;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(rpc_response), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.res <- Some (Pbrt.Decoder.bytes d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(rpc_response), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    call_id = v.call_id;
    res = v.res;
  } : rpc_response)

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf YoJson Encoding} *)

let rec encode_json_empty (v:empty) = 
Pbrt_yojson.make_unit v

let rec encode_json_loop_status (v:loop_status) = 
  match v with
  | Loop_status_none -> `String "LOOP_STATUS_NONE"
  | Loop_status_track -> `String "LOOP_STATUS_TRACK"
  | Loop_status_playlist -> `String "LOOP_STATUS_PLAYLIST"

let rec encode_json_property (v:property) = 
  match v with
  | Property_can_control -> `String "PROPERTY_CAN_CONTROL"
  | Property_can_go_next -> `String "PROPERTY_CAN_GO_NEXT"
  | Property_can_go_previous -> `String "PROPERTY_CAN_GO_PREVIOUS"
  | Property_can_pause -> `String "PROPERTY_CAN_PAUSE"
  | Property_can_play -> `String "PROPERTY_CAN_PLAY"
  | Property_can_seek -> `String "PROPERTY_CAN_SEEK"
  | Property_loop_status -> `String "PROPERTY_LOOP_STATUS"
  | Property_maximum_rate -> `String "PROPERTY_MAXIMUM_RATE"
  | Property_metadata -> `String "PROPERTY_METADATA"
  | Property_minimum_rate -> `String "PROPERTY_MINIMUM_RATE"
  | Property_playback_status -> `String "PROPERTY_PLAYBACK_STATUS"
  | Property_position -> `String "PROPERTY_POSITION"
  | Property_rate -> `String "PROPERTY_RATE"
  | Property_shuffle -> `String "PROPERTY_SHUFFLE"
  | Property_volume -> `String "PROPERTY_VOLUME"

let rec encode_json_loop_status_optional (v:loop_status_optional) = 
  begin match v with
  | None -> `Assoc [("none", `Null)]
  | Value v -> `Assoc [("value", encode_json_loop_status v)]
  end

let rec encode_json_shuffle_optional (v:shuffle_optional) = 
  begin match v with
  | None -> `Assoc [("none", `Null)]
  | Value v -> `Assoc [("value", Pbrt_yojson.make_bool v)]
  end

let rec encode_json_property_update_playback_status (v:property_update_playback_status) = 
  match v with
  | Playback_status_playing -> `String "PLAYBACK_STATUS_PLAYING"
  | Playback_status_paused -> `String "PLAYBACK_STATUS_PAUSED"
  | Playback_status_stopped -> `String "PLAYBACK_STATUS_STOPPED"

let rec encode_json_property_update_metadata (v:property_update_metadata) = 
  let assoc = [] in 
  let assoc = ("oMprisTrackid", Pbrt_yojson.make_string v.o_mpris_trackid) :: assoc in
  let assoc = match v.mpris_length with
    | None -> assoc
    | Some v -> ("mprisLength", Pbrt_yojson.make_string (Int64.to_string v)) :: assoc
  in
  let assoc = match v.mpris_art_url_bytes with
    | None -> assoc
    | Some v -> ("mprisArtUrlBytes", Pbrt_yojson.make_bytes v) :: assoc
  in
  let assoc = match v.xesam_album with
    | None -> assoc
    | Some v -> ("xesamAlbum", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc =
    let l = v.xesam_album_artist |> List.map Pbrt_yojson.make_string in
    ("xesamAlbumArtist", `List l) :: assoc 
  in
  let assoc =
    let l = v.xesam_artist |> List.map Pbrt_yojson.make_string in
    ("xesamArtist", `List l) :: assoc 
  in
  let assoc = match v.xesam_as_text with
    | None -> assoc
    | Some v -> ("xesamAsText", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc = match v.xesam_audio_bpm with
    | None -> assoc
    | Some v -> ("xesamAudioBpm", Pbrt_yojson.make_int (Int32.to_int v)) :: assoc
  in
  let assoc = match v.xesam_auto_rating with
    | None -> assoc
    | Some v -> ("xesamAutoRating", Pbrt_yojson.make_float v) :: assoc
  in
  let assoc =
    let l = v.xesam_comment |> List.map Pbrt_yojson.make_string in
    ("xesamComment", `List l) :: assoc 
  in
  let assoc =
    let l = v.xesam_composer |> List.map Pbrt_yojson.make_string in
    ("xesamComposer", `List l) :: assoc 
  in
  let assoc = match v.d_xesam_content_created with
    | None -> assoc
    | Some v -> ("dXesamContentCreated", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc = match v.xesam_disc_number with
    | None -> assoc
    | Some v -> ("xesamDiscNumber", Pbrt_yojson.make_int (Int32.to_int v)) :: assoc
  in
  let assoc = match v.d_xesam_first_used with
    | None -> assoc
    | Some v -> ("dXesamFirstUsed", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc =
    let l = v.xesam_genre |> List.map Pbrt_yojson.make_string in
    ("xesamGenre", `List l) :: assoc 
  in
  let assoc = match v.d_xesam_last_used with
    | None -> assoc
    | Some v -> ("dXesamLastUsed", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc =
    let l = v.xesam_lyricist |> List.map Pbrt_yojson.make_string in
    ("xesamLyricist", `List l) :: assoc 
  in
  let assoc = match v.xesam_title with
    | None -> assoc
    | Some v -> ("xesamTitle", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc = match v.xesam_track_number with
    | None -> assoc
    | Some v -> ("xesamTrackNumber", Pbrt_yojson.make_int (Int32.to_int v)) :: assoc
  in
  let assoc = match v.xesam_url with
    | None -> assoc
    | Some v -> ("xesamUrl", Pbrt_yojson.make_string v) :: assoc
  in
  let assoc = match v.use_count with
    | None -> assoc
    | Some v -> ("useCount", Pbrt_yojson.make_int (Int32.to_int v)) :: assoc
  in
  let assoc = match v.xesam_user_rating with
    | None -> assoc
    | Some v -> ("xesamUserRating", Pbrt_yojson.make_float v) :: assoc
  in
  `Assoc assoc

let rec encode_json_property_update (v:property_update) = 
  begin match v with
  | Can_control v -> `Assoc [("canControl", Pbrt_yojson.make_bool v)]
  | Can_go_next v -> `Assoc [("canGoNext", Pbrt_yojson.make_bool v)]
  | Can_go_previous v -> `Assoc [("canGoPrevious", Pbrt_yojson.make_bool v)]
  | Can_pause v -> `Assoc [("canPause", Pbrt_yojson.make_bool v)]
  | Can_play v -> `Assoc [("canPlay", Pbrt_yojson.make_bool v)]
  | Can_seek v -> `Assoc [("canSeek", Pbrt_yojson.make_bool v)]
  | Loop_status v -> `Assoc [("loopStatus", encode_json_loop_status_optional v)]
  | Maximum_rate v -> `Assoc [("maximumRate", Pbrt_yojson.make_string (string_of_float v))]
  | Metadata v -> `Assoc [("metadata", encode_json_property_update_metadata v)]
  | Minimum_rate v -> `Assoc [("minimumRate", Pbrt_yojson.make_string (string_of_float v))]
  | Playback_status v -> `Assoc [("playbackStatus", encode_json_property_update_playback_status v)]
  | Position v -> `Assoc [("position", Pbrt_yojson.make_string (Int64.to_string v))]
  | Rate v -> `Assoc [("rate", Pbrt_yojson.make_string (string_of_float v))]
  | Shuffle v -> `Assoc [("shuffle", encode_json_shuffle_optional v)]
  | Volume v -> `Assoc [("volume", Pbrt_yojson.make_string (string_of_float v))]
  end

let rec encode_json_set_loop_status_request (v:set_loop_status_request) = 
  let assoc = [] in 
  let assoc = ("loopStatus", encode_json_loop_status v.loop_status) :: assoc in
  `Assoc assoc

let rec encode_json_set_rate_request (v:set_rate_request) = 
  let assoc = [] in 
  let assoc = ("rate", Pbrt_yojson.make_string (string_of_float v.rate)) :: assoc in
  `Assoc assoc

let rec encode_json_set_shuffle_request (v:set_shuffle_request) = 
  let assoc = [] in 
  let assoc = ("shuffle", Pbrt_yojson.make_bool v.shuffle) :: assoc in
  `Assoc assoc

let rec encode_json_set_volume_request (v:set_volume_request) = 
  let assoc = [] in 
  let assoc = ("volume", Pbrt_yojson.make_string (string_of_float v.volume)) :: assoc in
  `Assoc assoc

let rec encode_json_signal_update_seeked (v:signal_update_seeked) = 
  let assoc = [] in 
  let assoc = ("position", Pbrt_yojson.make_string (Int64.to_string v.position)) :: assoc in
  `Assoc assoc

let rec encode_json_signal_update (v:signal_update) = 
  begin match v with
  | Seeked v -> `Assoc [("seeked", encode_json_signal_update_seeked v)]
  end

let rec encode_json_fetch_property_request (v:fetch_property_request) = 
  let assoc = [] in 
  let assoc = ("property", encode_json_property v.property) :: assoc in
  `Assoc assoc

let rec encode_json_update (v:update) = 
  begin match v with
  | Property v -> `Assoc [("property", encode_json_property_update v)]
  | Signal v -> `Assoc [("signal", encode_json_signal_update v)]
  end

let rec encode_json_open_uri_request (v:open_uri_request) = 
  let assoc = [] in 
  let assoc = ("uri", Pbrt_yojson.make_string v.uri) :: assoc in
  `Assoc assoc

let rec encode_json_seek_request (v:seek_request) = 
  let assoc = [] in 
  let assoc = ("offset", Pbrt_yojson.make_string (Int64.to_string v.offset)) :: assoc in
  `Assoc assoc

let rec encode_json_set_position_request (v:set_position_request) = 
  let assoc = [] in 
  let assoc = ("oTrackId", Pbrt_yojson.make_string v.o_track_id) :: assoc in
  let assoc = ("offset", Pbrt_yojson.make_string (Int64.to_string v.offset)) :: assoc in
  `Assoc assoc

let rec encode_json_rpc_call (v:rpc_call) = 
  let assoc = [] in 
  let assoc = ("callId", Pbrt_yojson.make_string (Int64.to_string v.call_id)) :: assoc in
  let assoc = ("name", Pbrt_yojson.make_string v.name) :: assoc in
  let assoc = ("req", Pbrt_yojson.make_bytes v.req) :: assoc in
  `Assoc assoc

let rec encode_json_rpc_response (v:rpc_response) = 
  let assoc = [] in 
  let assoc = ("callId", Pbrt_yojson.make_string (Int64.to_string v.call_id)) :: assoc in
  let assoc = match v.res with
    | None -> assoc
    | Some v -> ("res", Pbrt_yojson.make_bytes v) :: assoc
  in
  `Assoc assoc

[@@@ocaml.warning "-27-30-39"]

(** {2 JSON Decoding} *)

let rec decode_json_empty d =
Pbrt_yojson.unit d "empty" "empty record"

let rec decode_json_loop_status json =
  match json with
  | `String "LOOP_STATUS_NONE" -> (Loop_status_none : loop_status)
  | `String "LOOP_STATUS_TRACK" -> (Loop_status_track : loop_status)
  | `String "LOOP_STATUS_PLAYLIST" -> (Loop_status_playlist : loop_status)
  | _ -> Pbrt_yojson.E.malformed_variant "loop_status"

let rec decode_json_property json =
  match json with
  | `String "PROPERTY_CAN_CONTROL" -> (Property_can_control : property)
  | `String "PROPERTY_CAN_GO_NEXT" -> (Property_can_go_next : property)
  | `String "PROPERTY_CAN_GO_PREVIOUS" -> (Property_can_go_previous : property)
  | `String "PROPERTY_CAN_PAUSE" -> (Property_can_pause : property)
  | `String "PROPERTY_CAN_PLAY" -> (Property_can_play : property)
  | `String "PROPERTY_CAN_SEEK" -> (Property_can_seek : property)
  | `String "PROPERTY_LOOP_STATUS" -> (Property_loop_status : property)
  | `String "PROPERTY_MAXIMUM_RATE" -> (Property_maximum_rate : property)
  | `String "PROPERTY_METADATA" -> (Property_metadata : property)
  | `String "PROPERTY_MINIMUM_RATE" -> (Property_minimum_rate : property)
  | `String "PROPERTY_PLAYBACK_STATUS" -> (Property_playback_status : property)
  | `String "PROPERTY_POSITION" -> (Property_position : property)
  | `String "PROPERTY_RATE" -> (Property_rate : property)
  | `String "PROPERTY_SHUFFLE" -> (Property_shuffle : property)
  | `String "PROPERTY_VOLUME" -> (Property_volume : property)
  | _ -> Pbrt_yojson.E.malformed_variant "property"

let rec decode_json_loop_status_optional json =
  let assoc = match json with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  let rec loop = function
    | [] -> Pbrt_yojson.E.malformed_variant "loop_status_optional"
    | ("none", _)::_-> (None : loop_status_optional)
    | ("value", json_value)::_ -> 
      (Value ((decode_json_loop_status json_value)) : loop_status_optional)
    
    | _ :: tl -> loop tl
  in
  loop assoc

let rec decode_json_shuffle_optional json =
  let assoc = match json with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  let rec loop = function
    | [] -> Pbrt_yojson.E.malformed_variant "shuffle_optional"
    | ("none", _)::_-> (None : shuffle_optional)
    | ("value", json_value)::_ -> 
      (Value (Pbrt_yojson.bool json_value "shuffle_optional" "Value") : shuffle_optional)
    
    | _ :: tl -> loop tl
  in
  loop assoc

let rec decode_json_property_update_playback_status json =
  match json with
  | `String "PLAYBACK_STATUS_PLAYING" -> (Playback_status_playing : property_update_playback_status)
  | `String "PLAYBACK_STATUS_PAUSED" -> (Playback_status_paused : property_update_playback_status)
  | `String "PLAYBACK_STATUS_STOPPED" -> (Playback_status_stopped : property_update_playback_status)
  | _ -> Pbrt_yojson.E.malformed_variant "property_update_playback_status"

let rec decode_json_property_update_metadata d =
  let v = default_property_update_metadata_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("oMprisTrackid", json_value) -> 
      v.o_mpris_trackid <- Pbrt_yojson.string json_value "property_update_metadata" "o_mpris_trackid"
    | ("mprisLength", json_value) -> 
      v.mpris_length <- Some (Pbrt_yojson.int64 json_value "property_update_metadata" "mpris_length")
    | ("mprisArtUrlBytes", json_value) -> 
      v.mpris_art_url_bytes <- Some (Pbrt_yojson.bytes json_value "property_update_metadata" "mpris_art_url_bytes")
    | ("xesamAlbum", json_value) -> 
      v.xesam_album <- Some (Pbrt_yojson.string json_value "property_update_metadata" "xesam_album")
    | ("xesamAlbumArtist", `List l) -> begin
      v.xesam_album_artist <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_album_artist"
      ) l;
    end
    | ("xesamArtist", `List l) -> begin
      v.xesam_artist <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_artist"
      ) l;
    end
    | ("xesamAsText", json_value) -> 
      v.xesam_as_text <- Some (Pbrt_yojson.string json_value "property_update_metadata" "xesam_as_text")
    | ("xesamAudioBpm", json_value) -> 
      v.xesam_audio_bpm <- Some (Pbrt_yojson.int32 json_value "property_update_metadata" "xesam_audio_bpm")
    | ("xesamAutoRating", json_value) -> 
      v.xesam_auto_rating <- Some (Pbrt_yojson.float json_value "property_update_metadata" "xesam_auto_rating")
    | ("xesamComment", `List l) -> begin
      v.xesam_comment <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_comment"
      ) l;
    end
    | ("xesamComposer", `List l) -> begin
      v.xesam_composer <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_composer"
      ) l;
    end
    | ("dXesamContentCreated", json_value) -> 
      v.d_xesam_content_created <- Some (Pbrt_yojson.string json_value "property_update_metadata" "d_xesam_content_created")
    | ("xesamDiscNumber", json_value) -> 
      v.xesam_disc_number <- Some (Pbrt_yojson.int32 json_value "property_update_metadata" "xesam_disc_number")
    | ("dXesamFirstUsed", json_value) -> 
      v.d_xesam_first_used <- Some (Pbrt_yojson.string json_value "property_update_metadata" "d_xesam_first_used")
    | ("xesamGenre", `List l) -> begin
      v.xesam_genre <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_genre"
      ) l;
    end
    | ("dXesamLastUsed", json_value) -> 
      v.d_xesam_last_used <- Some (Pbrt_yojson.string json_value "property_update_metadata" "d_xesam_last_used")
    | ("xesamLyricist", `List l) -> begin
      v.xesam_lyricist <- List.map (function
        | json_value -> Pbrt_yojson.string json_value "property_update_metadata" "xesam_lyricist"
      ) l;
    end
    | ("xesamTitle", json_value) -> 
      v.xesam_title <- Some (Pbrt_yojson.string json_value "property_update_metadata" "xesam_title")
    | ("xesamTrackNumber", json_value) -> 
      v.xesam_track_number <- Some (Pbrt_yojson.int32 json_value "property_update_metadata" "xesam_track_number")
    | ("xesamUrl", json_value) -> 
      v.xesam_url <- Some (Pbrt_yojson.string json_value "property_update_metadata" "xesam_url")
    | ("useCount", json_value) -> 
      v.use_count <- Some (Pbrt_yojson.int32 json_value "property_update_metadata" "use_count")
    | ("xesamUserRating", json_value) -> 
      v.xesam_user_rating <- Some (Pbrt_yojson.float json_value "property_update_metadata" "xesam_user_rating")
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    o_mpris_trackid = v.o_mpris_trackid;
    mpris_length = v.mpris_length;
    mpris_art_url_bytes = v.mpris_art_url_bytes;
    xesam_album = v.xesam_album;
    xesam_album_artist = v.xesam_album_artist;
    xesam_artist = v.xesam_artist;
    xesam_as_text = v.xesam_as_text;
    xesam_audio_bpm = v.xesam_audio_bpm;
    xesam_auto_rating = v.xesam_auto_rating;
    xesam_comment = v.xesam_comment;
    xesam_composer = v.xesam_composer;
    d_xesam_content_created = v.d_xesam_content_created;
    xesam_disc_number = v.xesam_disc_number;
    d_xesam_first_used = v.d_xesam_first_used;
    xesam_genre = v.xesam_genre;
    d_xesam_last_used = v.d_xesam_last_used;
    xesam_lyricist = v.xesam_lyricist;
    xesam_title = v.xesam_title;
    xesam_track_number = v.xesam_track_number;
    xesam_url = v.xesam_url;
    use_count = v.use_count;
    xesam_user_rating = v.xesam_user_rating;
  } : property_update_metadata)

let rec decode_json_property_update json =
  let assoc = match json with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  let rec loop = function
    | [] -> Pbrt_yojson.E.malformed_variant "property_update"
    | ("canControl", json_value)::_ -> 
      (Can_control (Pbrt_yojson.bool json_value "property_update" "Can_control") : property_update)
    | ("canGoNext", json_value)::_ -> 
      (Can_go_next (Pbrt_yojson.bool json_value "property_update" "Can_go_next") : property_update)
    | ("canGoPrevious", json_value)::_ -> 
      (Can_go_previous (Pbrt_yojson.bool json_value "property_update" "Can_go_previous") : property_update)
    | ("canPause", json_value)::_ -> 
      (Can_pause (Pbrt_yojson.bool json_value "property_update" "Can_pause") : property_update)
    | ("canPlay", json_value)::_ -> 
      (Can_play (Pbrt_yojson.bool json_value "property_update" "Can_play") : property_update)
    | ("canSeek", json_value)::_ -> 
      (Can_seek (Pbrt_yojson.bool json_value "property_update" "Can_seek") : property_update)
    | ("loopStatus", json_value)::_ -> 
      (Loop_status ((decode_json_loop_status_optional json_value)) : property_update)
    | ("maximumRate", json_value)::_ -> 
      (Maximum_rate (Pbrt_yojson.float json_value "property_update" "Maximum_rate") : property_update)
    | ("metadata", json_value)::_ -> 
      (Metadata ((decode_json_property_update_metadata json_value)) : property_update)
    | ("minimumRate", json_value)::_ -> 
      (Minimum_rate (Pbrt_yojson.float json_value "property_update" "Minimum_rate") : property_update)
    | ("playbackStatus", json_value)::_ -> 
      (Playback_status ((decode_json_property_update_playback_status json_value)) : property_update)
    | ("position", json_value)::_ -> 
      (Position (Pbrt_yojson.int64 json_value "property_update" "Position") : property_update)
    | ("rate", json_value)::_ -> 
      (Rate (Pbrt_yojson.float json_value "property_update" "Rate") : property_update)
    | ("shuffle", json_value)::_ -> 
      (Shuffle ((decode_json_shuffle_optional json_value)) : property_update)
    | ("volume", json_value)::_ -> 
      (Volume (Pbrt_yojson.float json_value "property_update" "Volume") : property_update)
    
    | _ :: tl -> loop tl
  in
  loop assoc

let rec decode_json_set_loop_status_request d =
  let v = default_set_loop_status_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("loopStatus", json_value) -> 
      v.loop_status <- (decode_json_loop_status json_value)
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    loop_status = v.loop_status;
  } : set_loop_status_request)

let rec decode_json_set_rate_request d =
  let v = default_set_rate_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("rate", json_value) -> 
      v.rate <- Pbrt_yojson.float json_value "set_rate_request" "rate"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    rate = v.rate;
  } : set_rate_request)

let rec decode_json_set_shuffle_request d =
  let v = default_set_shuffle_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("shuffle", json_value) -> 
      v.shuffle <- Pbrt_yojson.bool json_value "set_shuffle_request" "shuffle"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    shuffle = v.shuffle;
  } : set_shuffle_request)

let rec decode_json_set_volume_request d =
  let v = default_set_volume_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("volume", json_value) -> 
      v.volume <- Pbrt_yojson.float json_value "set_volume_request" "volume"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    volume = v.volume;
  } : set_volume_request)

let rec decode_json_signal_update_seeked d =
  let v = default_signal_update_seeked_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("position", json_value) -> 
      v.position <- Pbrt_yojson.int64 json_value "signal_update_seeked" "position"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    position = v.position;
  } : signal_update_seeked)

let rec decode_json_signal_update json =
  let assoc = match json with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  let rec loop = function
    | [] -> Pbrt_yojson.E.malformed_variant "signal_update"
    | ("seeked", json_value)::_ -> 
      (Seeked ((decode_json_signal_update_seeked json_value)) : signal_update)
    
    | _ :: tl -> loop tl
  in
  loop assoc

let rec decode_json_fetch_property_request d =
  let v = default_fetch_property_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("property", json_value) -> 
      v.property <- (decode_json_property json_value)
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    property = v.property;
  } : fetch_property_request)

let rec decode_json_update json =
  let assoc = match json with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  let rec loop = function
    | [] -> Pbrt_yojson.E.malformed_variant "update"
    | ("property", json_value)::_ -> 
      (Property ((decode_json_property_update json_value)) : update)
    | ("signal", json_value)::_ -> 
      (Signal ((decode_json_signal_update json_value)) : update)
    
    | _ :: tl -> loop tl
  in
  loop assoc

let rec decode_json_open_uri_request d =
  let v = default_open_uri_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("uri", json_value) -> 
      v.uri <- Pbrt_yojson.string json_value "open_uri_request" "uri"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    uri = v.uri;
  } : open_uri_request)

let rec decode_json_seek_request d =
  let v = default_seek_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("offset", json_value) -> 
      v.offset <- Pbrt_yojson.int64 json_value "seek_request" "offset"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    offset = v.offset;
  } : seek_request)

let rec decode_json_set_position_request d =
  let v = default_set_position_request_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("oTrackId", json_value) -> 
      v.o_track_id <- Pbrt_yojson.string json_value "set_position_request" "o_track_id"
    | ("offset", json_value) -> 
      v.offset <- Pbrt_yojson.int64 json_value "set_position_request" "offset"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    o_track_id = v.o_track_id;
    offset = v.offset;
  } : set_position_request)

let rec decode_json_rpc_call d =
  let v = default_rpc_call_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("callId", json_value) -> 
      v.call_id <- Pbrt_yojson.int64 json_value "rpc_call" "call_id"
    | ("name", json_value) -> 
      v.name <- Pbrt_yojson.string json_value "rpc_call" "name"
    | ("req", json_value) -> 
      v.req <- Pbrt_yojson.bytes json_value "rpc_call" "req"
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    call_id = v.call_id;
    name = v.name;
    req = v.req;
  } : rpc_call)

let rec decode_json_rpc_response d =
  let v = default_rpc_response_mutable () in
  let assoc = match d with
    | `Assoc assoc -> assoc
    | _ -> assert(false)
  in
  List.iter (function 
    | ("callId", json_value) -> 
      v.call_id <- Pbrt_yojson.int64 json_value "rpc_response" "call_id"
    | ("res", json_value) -> 
      v.res <- Some (Pbrt_yojson.bytes json_value "rpc_response" "res")
    
    | (_, _) -> () (*Unknown fields are ignored*)
  ) assoc;
  ({
    call_id = v.call_id;
    res = v.res;
  } : rpc_response)

module MPRIS = struct
  open Pbrt_services.Value_mode
  module Client = struct
    open Pbrt_services
    
    let fetchProperty : (fetch_property_request, unary, property_update, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"FetchProperty"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_fetch_property_request
        ~encode_pb_req:encode_pb_fetch_property_request
        ~decode_json_res:decode_json_property_update
        ~decode_pb_res:decode_pb_property_update
        () : (fetch_property_request, unary, property_update, unary) Client.rpc)
    open Pbrt_services
    
    let subscribe : (unit, unary, update, stream) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Subscribe"
        ~req_mode:Client.Unary
        ~res_mode:Client.Stream
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:decode_json_update
        ~decode_pb_res:decode_pb_update
        () : (unit, unary, update, stream) Client.rpc)
    open Pbrt_services
    
    let next : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Next"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let openUri : (open_uri_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"OpenUri"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_open_uri_request
        ~encode_pb_req:encode_pb_open_uri_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (open_uri_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let pause : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Pause"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let play : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Play"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let playPause : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"PlayPause"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let previous : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Previous"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let seek : (seek_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Seek"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_seek_request
        ~encode_pb_req:encode_pb_seek_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (seek_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let setPosition : (set_position_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"SetPosition"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_set_position_request
        ~encode_pb_req:encode_pb_set_position_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (set_position_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let stop : (unit, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"Stop"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:(fun () -> `Assoc [])
        ~encode_pb_req:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (unit, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let setLoopStatus : (set_loop_status_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"SetLoopStatus"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_set_loop_status_request
        ~encode_pb_req:encode_pb_set_loop_status_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (set_loop_status_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let setRate : (set_rate_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"SetRate"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_set_rate_request
        ~encode_pb_req:encode_pb_set_rate_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (set_rate_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let setShuffle : (set_shuffle_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"SetShuffle"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_set_shuffle_request
        ~encode_pb_req:encode_pb_set_shuffle_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (set_shuffle_request, unary, unit, unary) Client.rpc)
    open Pbrt_services
    
    let setVolume : (set_volume_request, unary, unit, unary) Client.rpc =
      (Client.mk_rpc 
        ~package:[]
        ~service_name:"MPRIS" ~rpc_name:"SetVolume"
        ~req_mode:Client.Unary
        ~res_mode:Client.Unary
        ~encode_json_req:encode_json_set_volume_request
        ~encode_pb_req:encode_pb_set_volume_request
        ~decode_json_res:(fun _ -> ())
        ~decode_pb_res:(fun d -> Pbrt.Decoder.empty_nested d)
        () : (set_volume_request, unary, unit, unary) Client.rpc)
  end
  
  module Server = struct
    open Pbrt_services
    
    let _rpc_fetchProperty : (fetch_property_request,unary,property_update,unary) Server.rpc = 
      (Server.mk_rpc ~name:"FetchProperty"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:encode_json_property_update
        ~encode_pb_res:encode_pb_property_update
        ~decode_json_req:decode_json_fetch_property_request
        ~decode_pb_req:decode_pb_fetch_property_request
        () : _ Server.rpc)
    
    let _rpc_subscribe : (unit,unary,update,stream) Server.rpc = 
      (Server.mk_rpc ~name:"Subscribe"
        ~req_mode:Server.Unary
        ~res_mode:Server.Stream
        ~encode_json_res:encode_json_update
        ~encode_pb_res:encode_pb_update
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_next : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Next"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_openUri : (open_uri_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"OpenUri"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_open_uri_request
        ~decode_pb_req:decode_pb_open_uri_request
        () : _ Server.rpc)
    
    let _rpc_pause : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Pause"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_play : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Play"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_playPause : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"PlayPause"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_previous : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Previous"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_seek : (seek_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Seek"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_seek_request
        ~decode_pb_req:decode_pb_seek_request
        () : _ Server.rpc)
    
    let _rpc_setPosition : (set_position_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"SetPosition"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_set_position_request
        ~decode_pb_req:decode_pb_set_position_request
        () : _ Server.rpc)
    
    let _rpc_stop : (unit,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"Stop"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:(fun _ -> ())
        ~decode_pb_req:(fun d -> Pbrt.Decoder.empty_nested d)
        () : _ Server.rpc)
    
    let _rpc_setLoopStatus : (set_loop_status_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"SetLoopStatus"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_set_loop_status_request
        ~decode_pb_req:decode_pb_set_loop_status_request
        () : _ Server.rpc)
    
    let _rpc_setRate : (set_rate_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"SetRate"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_set_rate_request
        ~decode_pb_req:decode_pb_set_rate_request
        () : _ Server.rpc)
    
    let _rpc_setShuffle : (set_shuffle_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"SetShuffle"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_set_shuffle_request
        ~decode_pb_req:decode_pb_set_shuffle_request
        () : _ Server.rpc)
    
    let _rpc_setVolume : (set_volume_request,unary,unit,unary) Server.rpc = 
      (Server.mk_rpc ~name:"SetVolume"
        ~req_mode:Server.Unary
        ~res_mode:Server.Unary
        ~encode_json_res:(fun () -> `Assoc [])
        ~encode_pb_res:(fun () enc -> Pbrt.Encoder.empty_nested enc)
        ~decode_json_req:decode_json_set_volume_request
        ~decode_pb_req:decode_pb_set_volume_request
        () : _ Server.rpc)
    
    let make
      ~fetchProperty
      ~subscribe
      ~next
      ~openUri
      ~pause
      ~play
      ~playPause
      ~previous
      ~seek
      ~setPosition
      ~stop
      ~setLoopStatus
      ~setRate
      ~setShuffle
      ~setVolume
      () : _ Server.t =
      { Server.
        service_name="MPRIS";
        package=[];
        handlers=[
           (fetchProperty _rpc_fetchProperty);
           (subscribe _rpc_subscribe);
           (next _rpc_next);
           (openUri _rpc_openUri);
           (pause _rpc_pause);
           (play _rpc_play);
           (playPause _rpc_playPause);
           (previous _rpc_previous);
           (seek _rpc_seek);
           (setPosition _rpc_setPosition);
           (stop _rpc_stop);
           (setLoopStatus _rpc_setLoopStatus);
           (setRate _rpc_setRate);
           (setShuffle _rpc_setShuffle);
           (setVolume _rpc_setVolume);
        ];
      }
  end
  
end
