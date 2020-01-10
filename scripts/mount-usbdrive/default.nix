{ stdenv
, bash
, coreutils
, utillinux
}:

stdenv.mkDerivation rec {
  name = "mount-usbdrive";

  src = ./.;

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/mount-usbdrive

    mkdir -p $out/bin

    substitute mount-usbdrive.sh $exe \
      --subst-var-by bash "${bash}/bin/bash" \
      --subst-var-by id "${coreutils}/bin/id" \
      --subst-var-by mount "${utillinux}/bin/mount"

    chmod +x $exe
  '';
}
