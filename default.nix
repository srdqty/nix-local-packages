let
  pkgs = import ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a;

  idris = pkgs.idrisPackages.with-packages (with pkgs.idrisPackages; [
    prelude
    base
    contrib
  ]);

  custom-emacs = pkgs.callPackage ./custom-emacs {
    idrisWithPackages = idris;
  };
  emc = pkgs.callPackage ./custom-emacs/emc.nix { emacs = custom-emacs; };
  helm = pkgs.callPackage ./helm {};

  config = {
    allowUnfree = true;
    allowBroken = false;
    chromium = {
      enableWideVine = false;
    };
  };

  newerpkgs = import ./nixpkgs/6b9d8a21fe3a21c23432bef91889a5c1fbc7f54e {
    inherit config;
  };
in
  {
    inherit custom-emacs emc helm;

    inherit (newerpkgs)
      chromium
      google-chrome
      ;

    inherit (pkgs)
      openjdk
      pypi2nix
      alarm-clock-applet
      awscli
      binutils
      coreutils
      curl
      docker_compose
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
      racket
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
      idris
    ;
    inherit (pkgs.pythonPackages)
      livestreamer
    ;
  }
