# tools — tool execution settings configuration for gemini-cli
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
