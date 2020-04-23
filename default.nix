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
  pkgs-2019-10-02 = import nixpkgs/2436c27541b2f52deea3a4c1691216a02152e729 { inherit config; };
  pkgs-2019-12-13 = import nixpkgs/f4ad230f90ef312695adc26f256036203e9c70af { inherit config; };
  pkgs-2020-01-13 = import nixpkgs/81101ce9d122a401142bd7cc91eb4c89cde7a526 { inherit config; };
  pkgs-2020-02-25 = import nixpkgs/26277c18fbe259b7480455350f284b6571ed61ed { inherit config; };
  pkgs-2020-04-06 = import nixpkgs/05f0934825c2a0750d4888c4735f9420c906b388 { inherit config; };

  agda = (import ./agda).agdaWithPackages (pkgs: with pkgs; [
    agda-stdlib
    ial
  ]);
  avro-tools = pkgs.callPackage ./avro-tools {};
  check-instance-az = pkgs.callPackage ./scripts/check-instance-az {};
  convert-video = pkgs.callPackage ./scripts/convert-video {};
  mount-usbdrive = pkgs.callPackage ./scripts/mount-usbdrive {};
  helm = pkgs.callPackage ./helm {};
  kubectl = pkgs.callPackage ./kubectl {};
  minikube = pkgs.callPackage ./minikube {};
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
      mount-usbdrive
      custom-emacs
      helm
      kubectl
      rust
      minikube
      ;

    inherit (pkgs-2020-04-06)
      alarm-clock-applet
      autorandr
      chromium
      discord
      google-chrome
      smartmontools
      networkmanagerapplet
      obs-studio
      qbittorrent
      youtube-dl
      slack
      tree
      xscreensaver
      mpv
      smplayer # requires mpv
      vlc
      ;

    inherit (pkgs-2020-02-25)
      alacritty
      spotify
      rustup
      shellcheck
      ;

    inherit (pkgs-2020-01-13)
      firefox
      etcd
      go_1_13
      ;

    inherit (pkgs-2019-12-13)
      gcc-arm-embedded
      gcc
      minicom
      openocd
      bluezFull
      rfkill
      jsonnet
      ;

    inherit (pkgs-2019-10-02)
      yaml2json
      ;

    inherit (pkgs-2019-08-15)
      awscli
      ;

    inherit (pkgs-2019-07-15)
      telnet
      wirelesstools
      ;

    inherit (newestpkgs)
      maven
      socat
      ;

    inherit (pkgs)
      openjdk
      pypi2nix
      binutils
      coreutils
      curl
      docker_compose
      jq
      git
      hicolor-icon-theme # needed by network manager applet?
      mlton
      numlockx
      p7zip
      parcellite
      playerctl
      pnmixer
      racket
      ripgrep
      rxvt_unicode-with-plugins
      stalonetray
      steam
      unrar
      unzip
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
