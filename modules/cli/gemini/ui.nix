# ui — UI and theme settings configuration for gemini-cli
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
