let
  pkgs = import ./nixpkgs-pinned { overlays = import ./overlays.nix; };
in
  {
    inherit (pkgs)
      keybase-gui
      kbfs
      qbittorrent
      pcsx2
      telegram;
  }
