{ lib, melpaBuild, fetchgit, evil, writeText, cl-lib }:

melpaBuild rec {
  pname    = "evil-escape";
  version = "3.15";

  src = fetchgit {
    url = "https://github.com/srdqty/evil-escape";
    sha256 = "0qk58slca0hn11b523kqg441xnms3i3yi3jdh2sx1iszl3hfl6s7";
    rev = "b8d7cbf9b8d8de4a737b826273e6a9a0de0f9eb3";
  };

  packageRequires = [ evil ];


  recipe = writeText "recipe" ''
    (evil-escape :repo "syl20bnr/evil-escape" :fetcher github)
  '';
}