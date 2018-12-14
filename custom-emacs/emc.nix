{ bash, emacs, stdenv, writeScript }:
let
  emc = writeScript "emc.sh" ''
    #!${bash}/bin/bash

    ${emacs}/bin/emacsclient -a "" -c -nw $*
  '';

  kill = writeScript "kill-emacs-daemon.sh" ''
    #!${bash}/bin/bash

    ${emacs}/bin/emacsclient --eval '(kill-emacs)'
  '';

in
stdenv.mkDerivation rec {
  name = "emc";

  src = ./.;

  doBuild = false;

  buildInputs = [emacs];

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T ${emc} $out/bin/emc
    install -D -m555 -T ${kill} $out/bin/kill-emacs-daemon
  '';
}
