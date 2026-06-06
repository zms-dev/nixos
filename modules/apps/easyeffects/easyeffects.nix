/*
  EasyEffects — non-destructive audio effects processor for PipeWire
  https://github.com/wwmm/easyeffects
  GTK4 app; operates as a PipeWire filter chain via a virtual sink node.
*/
{ ... }:
{
  den.aspects.apps._.easyeffects = {
    nixos =
      { ... }:
      {
        programs.dconf.enable = true;

        services.pipewire.extraConfig.pipewire."99-easyeffects" = {
          "rules" = [
            {
              matches = [ { "node.name" = "easyeffects_sink"; } ];
              actions = {
                update-props = {
                  "priority.session" = 2000;
                };
              };
            }
          ];
        };
      };

    homeManager =
      { ... }:
      {
        services.easyeffects = {
          enable = true;
          preset = "basssss";
          extraPresets.basssss = builtins.fromJSON (builtins.readFile ./bass-preset.json);
        };
      };
  };
}
