{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "kubectl-${version}";
  version = "v1.16.3";

  src = fetchurl {
    url = "https://storage.googleapis.com/kubernetes-release/release/${version}/bin/linux/amd64/kubectl";
    sha256 = "0b8grhjry0ndbxgiraxhbf0mwr37v5zpajq265gmfhap8131pvfd";
  };

  unpackPhase = "true";

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/kubectl

    mkdir -p $out/bin
    install -D -m555 -T ${src} $exe
  '';
}
