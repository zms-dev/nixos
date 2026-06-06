/*
  nh — Nix Helper; ergonomic wrapper around nixos-rebuild and home-manager with better output and dry-run support
  https://github.com/viperML/nh
*/
{ ... }:
{
  den.aspects.cli._.nh = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nh ];
      };
  };
}
