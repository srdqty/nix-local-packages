let
  pkgs = import ./nixpkgs-pinned { overlays = import ./overlays.nix; };
in
  {
    inherit (pkgs) qbittorrent telegram;
  }
