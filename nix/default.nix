{ stdenv
, lib
, ocamlPackages
, static ? false
, nix-filter
, crossName ? null
}:

ocamlPackages.buildDunePackage {
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
    dune build client_bridge/main.exe -j $NIX_BUILD_CORES --display=short --profile=${if static then "static" else "release"}
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv _build/default/client_bridge/main.exe $out/bin/client_bridge
  '';
}
