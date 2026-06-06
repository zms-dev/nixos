{ ... }:
{
  den.aspects.cli._.gemini-cli._.ui = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.ui = {
          theme = "Default";
        };
      };
  };
}
