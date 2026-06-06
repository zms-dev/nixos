/*
  swww — animated Wayland wallpaper daemon using wlr-layer-shell; GPU-accelerated transitions and runtime wallpaper switching
  https://github.com/LGFae/swww
*/
{ ... }:
{
  den.aspects.gui._.awww = {
    homeManager =
      { ... }:
      {
        services.awww.enable = true;
      };
  };
}
