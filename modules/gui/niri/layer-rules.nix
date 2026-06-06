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
