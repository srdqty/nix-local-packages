{ stdenv
, bash
, ffmpeg
}:

stdenv.mkDerivation rec {
  # Convert video lowest common denominator
  # See: https://superuser.com/a/859075
  name = "convert-video-lcd";

  src = ./.;

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/convert-video-lcd

    mkdir -p $out/bin

    substitute convert-video-lcd.sh $exe \
      --subst-var-by bash "${bash}/bin/bash" \
      --subst-var-by ffmpeg "${ffmpeg}/bin/ffmpeg"

    chmod +x $exe
  '';
}
