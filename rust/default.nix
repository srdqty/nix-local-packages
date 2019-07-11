{ nixpkgs }:

let
  src = nixpkgs.fetchFromGitHub {
      owner = "mozilla";
      repo = "nixpkgs-mozilla";
      # commit from: 2019-06-13
      rev = "200cf0640fd8fdff0e1a342db98c9e31e6f13cd7";
      sha256 = "1am353ims43ylvay263alchzy3y87r1khnwr0x2fp35qr347bvxi";
    };
  rust = import "${src.out}/rust-overlay.nix" nixpkgs nixpkgs;
  nightly = rust.rustChannelOf { date = "2019-07-11"; channel = "nightly"; };
in
  nightly.rust.override {
    extensions = ["clippy-preview" "rustfmt-preview"];
  }
