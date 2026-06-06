/*
  shfmt — formatter for shell scripts
  https://github.com/mvdan/sh
*/
{ ... }:
{
  den.aspects.dev._.shfmt = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.shfmt ];
      };
  };
}
