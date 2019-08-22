let
  config = {
    allowUnfree = true;
    allowBroken = false;
    chromium = {
      enableWideVine = false;
    };
  };

  pkgs = import ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a;
  newerpkgs = import ./nixpkgs/6b9d8a21fe3a21c23432bef91889a5c1fbc7f54e { inherit config; };
  newestpkgs = import ./nixpkgs/c89b2de425db938a06a418a11f792ca1ab7ea9ff { inherit config; };
  pkgs-2019-07-15 = import ./nixpkgs/6b89e87a234cb8471aff2562e5381ebbbe6df156 { inherit config; };
  pkgs-2019-08-15 = import ./nixpkgs/2edd7103dab1e43a233d7fee890461887e5f6e1d { inherit config; };

  agda = (import ./agda).agdaWithPackages (pkgs: with pkgs; [
    agda-stdlib
    ial
  ]);
  avro-tools = pkgs.callPackage ./avro-tools {};
  check-instance-az = pkgs.callPackage ./scripts/check-instance-az {};
  convert-video = pkgs.callPackage ./scripts/convert-video {};
  helm = pkgs.callPackage ./helm {};
  idris = pkgs.idrisPackages.with-packages (with pkgs.idrisPackages; [
    prelude
    base
    contrib
  ]);
  rust = import ./rust { nixpkgs = newestpkgs; };

  custom-emacs = pkgs.callPackage ./custom-emacs {
    idrisWithPackages = idris;
    agdaWithPackages = agda;
  };
in
  {
    inherit
      avro-tools
      check-instance-az
      convert-video
      custom-emacs
      helm
      rust
      ;

    inherit (pkgs-2019-08-15)
      awscli
      discord
      firefox
      slack
      spotify
      ;

    inherit (pkgs-2019-07-15)
      telnet
      wirelesstools
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
