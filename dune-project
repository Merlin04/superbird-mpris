(lang dune 3.15)

(name superbird_mpris)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name superbird_mpris)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune mpris obus lwt react ocaml-protoc pbrt pbrt_services ounit2)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
