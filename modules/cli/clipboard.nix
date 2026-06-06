/*
  wl-clipboard — Wayland clipboard utilities (wl-copy/wl-paste) with wl-clip-persist daemon
  https://github.com/bugaevc/wl-clipboard
*/
{ ... }:
{
  den.aspects.cli._.clipboard = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.wl-clipboard ];
        services.wl-clip-persist.enable = true;
      };
  };
}
