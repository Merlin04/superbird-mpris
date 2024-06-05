#!/bin/sh

ocaml-protoc --binary --services --ml_out ./ mpris_pb.proto
echo "done :3"
