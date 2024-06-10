# `superbird-mpris`

This is a work-in-progress project that lets you view and control what's playing
on your Linux computer with a Spotify Car Thing.

This could also be extended to support more platforms/services - it uses a
communication protocol based on MPRIS that you should easily be able to adapt
data from other sources into. 

- daemon: runs on your computer, communicates with the Car Thing over serial
  using a custom protobuf-based RPC protocol
- lib: the MPRIS-based protobuf format that the client and daemon use to communicate
- client: runs on the car thing, bridges the serial connection to a websocket so
  the frontend can connect to it
- webapp: TODO