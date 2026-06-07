/*
  layer-rules — Wayland layer rules configuration for the niri compositor
  https://github.com/YaLTeR/niri
*/
{ ... }:
{
  den.aspects.gui._.niri._.layer-rules = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.niri.settings.layer-rules = [
          {
            matches = [
              { namespace = "^quickshell$"; }
            ];
            place-within-backdrop = true;
          }
        ];
      };
  };
}
