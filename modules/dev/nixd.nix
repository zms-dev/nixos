/*
  nixd — Nix language server with nixpkgs/flake-aware completion and diagnostics
  https://github.com/nix-community/nixd
*/
{ ... }:
{
  den.aspects.dev._.nixd = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nixd ];
      };
  };
}
