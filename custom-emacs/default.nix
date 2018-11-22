{ emacs, emacsPackages, emacsPackagesNgGen, runCommand, coq }:

let
  emacsWithPackages = (emacsPackagesNgGen emacs).emacsWithPackages;

  default-el = ./default.el;

  default-el-pkg = runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${default-el} $out/share/emacs/site-lisp/default.el
    substituteInPlace $out/share/emacs/site-lisp/default.el \
      --subst-var-by coq-path ${coq}
  '';
in
  emacsWithPackages (pkgs: (with pkgs; [
    default-el-pkg
    use-package
    evil

    dhall-mode
    futhark-mode
    emacsPackages.proofgeneral
    haskell-mode
    nix-mode
  ]))
