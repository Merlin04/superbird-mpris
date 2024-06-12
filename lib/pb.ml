let encoder_size = 2048

let make_encoder () = Pbrt.Encoder.create ~size:encoder_size ()

let encode_with_pbrt_fn (pbrt_encoder : Pbrt.Encoder.t) (encode : 't -> Pbrt.Encoder.t -> unit) (v : 't) : bytes =
  encode v pbrt_encoder;
  let b = Pbrt.Encoder.to_bytes pbrt_encoder in
  (if Bytes.length b > encoder_size then
    Pbrt.Encoder.reset
  else
    Pbrt.Encoder.clear) pbrt_encoder;
  b