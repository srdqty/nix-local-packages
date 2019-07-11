{ nixpkgs }:

let
  src = nixpkgs.fetchFromGitHub {
      owner = "srdqty";
      repo = "nixpkgs-mozilla";
      # commit from: 2019-06-13
      rev = "50778edc9398649bf77ace77124475df2c7d5bc5";
      sha256 = "1fiqpd6k3k0b5g1l95dwix0rydhrr4ih1275gmxx1vh52my697hl";
    };
  rust = import "${src.out}/rust-overlay.nix" nixpkgs nixpkgs;
  nightly = rust.rustChannelOf { date = "2019-07-11"; channel = "nightly"; };
in
  nightly.rust.override {
    extensions = ["clippy-preview" "rustfmt-preview"];
  }
