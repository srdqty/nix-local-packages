let
  pkgs = import ./util/fetch-nixpkgs.nix {
    args = ./nixpkgs/44f24a1b8c46ece8e510dd45d4f5683c1813c00a.json;
  };
in
  {
    inherit (pkgs) chromium;
  }
