let
  pkgs = import ./nixpkgs-pinned { overlays = import ./overlays.nix; };
in
  {
    inherit (pkgs)
      qbittorrent
      pcsx2
      telegram;
  }
