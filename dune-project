(lang dune 3.15)

(name superbird_mpris)

(generate_opam_files true)

(source
 (github Merlin04/superbird-mpris))

(authors "Merlin04")

(maintainers "Merlin04")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name superbird_mpris)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
  ocaml dune ounit2 lwt react
  mpris obus
  ocaml-protoc pbrt pbrt_services
  cobs
  ctypes ctypes-foreign stdint
  websocket websocket-lwt-unix)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
