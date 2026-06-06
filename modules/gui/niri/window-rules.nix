{ ... }:
{
  den.aspects.gui._.niri._.window-rules = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.niri.settings.window-rules = [
          {
            geometry-corner-radius = {
              top-left = 12.0;
              top-right = 12.0;
              bottom-left = 12.0;
              bottom-right = 12.0;
            };
            clip-to-geometry = true;
          }
          {
            matches = [
              { is-active = false; }
            ];
            opacity = 0.95;
            # background-effect = {
            #   blur = true;
            #   xray = true;
            # };
          }
        ];
      };
  };
}
