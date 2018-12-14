let
  pkgs = import ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a;

  custom-emacs = pkgs.callPackage ./custom-emacs {};
  emc = pkgs.callPackage ./custom-emacs/emc.nix { emacs = custom-emacs; };
in
  {
    inherit custom-emacs emc;

    inherit (pkgs)
      alarm-clock-applet
      awscli
      binutils
      chromium
      coreutils
      curl
      jq
      git
      hicolor-icon-theme # needed by network manage applet?
      mlton
      mpv
      networkmanagerapplet
      numlockx
      p7zip
      parcellite
      playerctl
      pnmixer
      qbittorrent
      ripgrep
      rxvt_unicode-with-plugins
      slack
      smplayer # requires mpv
      spotify
      stalonetray
      steam
      unrar
      unzip
      xscreensaver
      youtube-dl
      zathura
    ;
    inherit (pkgs.haskellPackages)
      xmonad
      xmobar
    ;
    inherit (pkgs.pythonPackages)
      livestreamer
    ;
  }
