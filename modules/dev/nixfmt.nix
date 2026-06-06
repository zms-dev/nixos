/*
  nixfmt — opinionated formatter for Nix files
  https://github.com/nix-community/nixfmt
*/
{ ... }:
{
  den.aspects.dev._.nixfmt = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nixfmt ];
      };
  };
}
