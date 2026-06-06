{ ... }:
{
  den.aspects.gui._.niri._.workspaces = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.niri.settings.workspaces = {
          "1".name = "one";
          "2".name = "two";
          "3".name = "three";
        };
      };
  };
}
