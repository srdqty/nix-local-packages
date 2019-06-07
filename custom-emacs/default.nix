{ emacs
, emacsPackages
, emacsPackagesNgGen
, git
, runCommand
, coq
, xclip
, hlint
, idrisWithPackages
, agdaWithPackages
}:

let
  emacsWithPackages = (emacsPackagesNgGen emacs).emacsWithPackages;

  default-el = ./default.el;

  default-el-pkg = runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${default-el} $out/share/emacs/site-lisp/default.el
    substituteInPlace $out/share/emacs/site-lisp/default.el \
      --subst-var-by coq-path ${coq} \
      --subst-var-by hlint-path ${hlint} \
      --subst-var-by xclip-path ${xclip} \
      --subst-var-by idris-path ${idrisWithPackages} \
      --subst-var-by agda-path ${agdaWithPackages} \
      --subst-var-by git ${git}
  '';
in
  emacsWithPackages (pkgs: (with pkgs; [
    default-el-pkg
    use-package
    evil
    evil-leader

    dhall-mode
    doom-themes
    futhark-mode
    emacsPackages.proofgeneral
    haskell-mode
    idris-mode
    json-mode
    magit
    markdown-mode
    #    neotree
    nix-mode
    pollen-mode
    rust-mode
    solarized-theme
    xclip
    yaml-mode
  ]))
