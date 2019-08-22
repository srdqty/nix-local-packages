{ stdenv
, fetchurl
, bash
, openjdk
}:

let
  version = "1.9.0";

  jar = fetchurl {
    url = "https://archive.apache.org/dist/avro/avro-${version}/java/avro-tools-${version}.jar";
    sha256 = "07lhadp6y7l5cgjz9mjv14rpsj6hppqri8a37fcadh60adkmbqh9";
  };
in

stdenv.mkDerivation {
  name = "avro-tools-${version}";
  inherit version;

  src = ./.;

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/avro-tools
    mkdir -p $out/bin

    substitute avro-tools.sh $exe \
      --subst-var-by bash "${bash}/bin/bash" \
      --subst-var-by java "${openjdk}/bin/java" \
      --subst-var-by avro-tools-jar "${jar}"

    chmod +x $exe
  '';
}
