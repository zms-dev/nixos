/*
  nh — command-line Nix helper for simplified system building and updates
  https://github.com/viperML/nh
*/
{ den, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };
}
