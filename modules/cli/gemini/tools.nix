{ ... }:
{
  den.aspects.cli._.gemini-cli._.tools = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.tools = {
          autoAccept = false;
        };
      };
  };
}
