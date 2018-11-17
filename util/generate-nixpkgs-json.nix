{ owner ? "NixOS"
, repo ? "nixpkgs"
, rev
}:

let
  pkgs = import <nixpkgs> {};

  url="https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";

  file = builtins.fetchTarball { url = url; };

  json = builtins.toFile "data.json" ''
    { "url": "${url}"
    , "rev": "${rev}"
    , "owner": "${owner}"
    , "repo": "${repo}"
    }
  '';

  sha256calc = "nix-hash --type sha256 --base32 ${file}";

  out-path = builtins.toString ../nixpkgs;
in


pkgs.stdenv.mkDerivation rec {
  name = "generate-nixpkgs-json";

  buildInputs = [
    pkgs.jq
    pkgs.nix
  ];

  shellHook = ''
    set -eu
    sha256=$(${sha256calc})
    jq .+="{\"sha256\":\"$sha256\"}" ${json} > ${out-path}/${rev}.json
    exit
  '';
}
