let
  haskellOverlay = (self: super: {
    haskellPackages = super.haskell.packages."ghc822".override {
      overrides = new: old: {
      };
    };
  });

  nonHaskellOverlay = (self: super: {
    telegram = super.callPackage ./pkgs/telegram-bin {};
  });
in
  [nonHaskellOverlay haskellOverlay]
