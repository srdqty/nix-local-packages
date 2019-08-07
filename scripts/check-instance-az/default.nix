{ stdenv
, bash
, awscli
, jq
, coreutils
}:

stdenv.mkDerivation rec {
  name = "check-instance-az";

  src = ./.;

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    exe=$out/bin/check-instance-az

    mkdir -p $out/bin

    substitute check-instance-az.sh $exe \
      --subst-var-by aws "${awscli}/bin/aws" \
      --subst-var-by bash "${bash}/bin/bash" \
      --subst-var-by jq "${jq}/bin/jq" \
      --subst-var-by sort "${coreutils}/bin/sort" \
      --subst-var-by uniq "${coreutils}/bin/uniq"

    chmod +x $exe
  '';
}
