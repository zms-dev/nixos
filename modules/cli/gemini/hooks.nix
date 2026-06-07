# hooks — event hooks configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.hooks = {
          AfterTool = [
            {
              hooks = [ ];
            }
          ];
          AfterAgent = [
            {
              hooks = [ ];
            }
          ];
          SessionEnd = [
            {
              hooks = [ ];
            }
          ];
        };
      };
  };
}
