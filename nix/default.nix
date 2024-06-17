{ stdenv
, lib
, ocamlPackages
, profile ? "release"
, nix-filter
, crossName ? null
}:

stdenv.mkDerivation {
  pname = "superbird_mprisbridge";
  version = "n/a";
  src = with nix-filter; filter {
    root = ./..;
    include = [
      "dune"
      "dune-project"
      "superbird_mpris.opam"
      "client_bridge"
      "lib"
      "test"
    ];
  };

  nativeBuildInputs = with ocamlPackages; [ dune ocaml findlib ];

  OCAMLFIND_TOOLCHAIN = crossName;
  propagatedBuildInputs = with ocamlPackages;
    [
      lwt
      cobs
      websocket
      websocket-lwt-unix
      pbrt
      pbrt_services
    ];

  buildPhase = ''
    dune build client_bridge/main.exe \
      --display=short \
      -j $NIX_BUILD_CORES \
      --profile=${profile}
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv _build/default/client_bridge/main.exe $out/bin/client_bridge
  '';
}
