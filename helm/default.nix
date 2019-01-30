{ stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "helm-${version}";
  version = "v2.12.3";

  src = fetchurl {
    url = "https://storage.googleapis.com/kubernetes-helm/helm-${version}-linux-amd64.tar.gz";
    sha256 = "01wih03mki8mn496z82lhjxjb8i4pnhdim9ppbrbvnjlg6rs299l";
  };

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/helm

    mkdir -p $out/bin
    install -D -m555 -T helm $exe
  '';
}
