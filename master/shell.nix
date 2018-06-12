let
  pkgs = import ./nixpkgs-pinned { overlays = import ./overlays.nix {}; };
in
  pkgs.stdenv.mkDerivation {
    name = "nix-local-packages-master";

    buildInputs = [
      pkgs.ncurses # Needed by the bash-prompt.sh script
    ];

    shellHook = builtins.readFile ./bash-prompt.sh + ''
      source ${pkgs.git.out}/etc/bash_completion.d/git-prompt.sh
      source ${pkgs.git.out}/etc/bash_completion.d/git-completion.bash
    '';
  }
