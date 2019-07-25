let
  pkgs = import ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a;

  idris = pkgs.idrisPackages.with-packages (with pkgs.idrisPackages; [
    prelude
    base
    contrib
  ]);

  agda = (import ./agda).agdaWithPackages (pkgs: with pkgs; [
    agda-stdlib
    ial
  ]);

  custom-emacs = pkgs.callPackage ./custom-emacs {
    idrisWithPackages = idris;
    agdaWithPackages = agda;
  };
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

  newestpkgs = import ./nixpkgs/c89b2de425db938a06a418a11f792ca1ab7ea9ff {
    inherit config;
  };

  convert-video-lcd = pkgs.callPackages ./convert-video-lcd {};

  rust = import ./rust { nixpkgs = newestpkgs; };


  pkgs-2019-07-15 = import ./nixpkgs/6b89e87a234cb8471aff2562e5381ebbbe6df156 {
    inherit config;
  };
in
  {
    inherit
      convert-video-lcd
      custom-emacs
      helm
      rust
      ;

    inherit (pkgs-2019-07-15)
      slack
      spotify
      ;

    inherit (newerpkgs)
      chromium
      google-chrome
      ;

    inherit (newestpkgs)
      maven
      socat
      youtube-dl
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
      hicolor-icon-theme # needed by network manager applet?
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
      smplayer # requires mpv
      stalonetray
      steam
      unrar
      unzip
      xscreensaver
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
