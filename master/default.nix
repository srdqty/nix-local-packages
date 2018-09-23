let
  pkgs = import ./nixpkgs-pinned { overlays = import ./overlays.nix; };
in
  {
    inherit (pkgs)
      dolphinEmu
      keybase-gui
      kbfs
      qbittorrent
      pcsx2
      telegram;
  }
