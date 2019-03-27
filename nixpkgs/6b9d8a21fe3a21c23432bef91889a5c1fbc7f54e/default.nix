{ config }:
  import ../../util/fetch-nixpkgs.nix { inherit config; args = ./args.json; }
