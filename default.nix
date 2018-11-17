let
  pkgs = import ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a;
in
  {
    inherit (pkgs) chromium;
  }
