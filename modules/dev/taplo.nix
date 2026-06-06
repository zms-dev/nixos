/*
  taplo — TOML toolkit and language server
  https://github.com/tamasfe/taplo
*/
{ ... }:
{
  den.aspects.dev._.taplo = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.taplo ];
      };
  };
}
