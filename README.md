```
nix-shell util/generate-nixpkgs-json.nix --argstr rev <git-revision>
nix-env -f default.nix -iA <package-name>
```
