/*
  just — command runner with a justfile syntax; simpler make alternative
  https://github.com/casey/just
*/
{ ... }:
{
  den.aspects.cli._.just = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.just ];
      };
  };
}
