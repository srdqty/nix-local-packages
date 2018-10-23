let
  pkgs = import ./nixpkgs-pinned {
    overlays = import ./overlays.nix;
    config = import ./config.nix;
  };
in
  {
    inherit (pkgs)
      dolphinEmu
      keybase-gui
      kbfs
      qbittorrent
      pcsx2
      spotify
      telegram;
  }
