{ customEmacsPackages
, emacsPackages
, runCommand
, coq
, xclip
, hlint
}:

let
  emacsWithPackages = customEmacsPackages.emacsWithPackages;

  default-el = ./default.el;

  default-el-pkg = runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${default-el} $out/share/emacs/site-lisp/default.el
    substituteInPlace $out/share/emacs/site-lisp/default.el \
      --subst-var-by coq-path ${coq} \
      --subst-var-by hlint-path ${hlint} \
      --subst-var-by xclip-path ${xclip}
  '';

  custom-evil-escape = customEmacsPackages.callPackage ./evil-escape {};
in
  emacsWithPackages (pkgs: (with pkgs; [
    default-el-pkg
    dhall-mode
    doom-themes
    evil
    custom-evil-escape
    futhark-mode
    emacsPackages.proofgeneral
    haskell-mode
    idris-mode
    json-mode
    markdown-mode
    nix-mode
    use-package
    xclip
    yaml-mode
  ]))
