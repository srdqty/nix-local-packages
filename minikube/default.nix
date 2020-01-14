{ stdenv, patchelf, fetchurl }:

let
  dynamic-linker = stdenv.cc.bintools.dynamicLinker;
in
stdenv.mkDerivation rec {
  name = "minikube-${version}";
  version = "1.6.2";

  src = fetchurl {
    url = "https://storage.googleapis.com/minikube/releases/v${version}/minikube-linux-amd64";
    sha256 = "1awin314lly913zpmgiyxwxw374i07411f7pn2j2jgcm71s05gga";
  };

  unpackPhase = "true";

  dontBuild = true;

  installPhase = ''
    exe=$out/bin/minikube

    mkdir -p $out/bin
    install -D -m555 -T ${src} $exe
  '';

  postFixup = stdenv.lib.optionalString stdenv.isLinux ''
    patchelf --set-interpreter ${dynamic-linker} $out/bin/minikube
  '';
}
