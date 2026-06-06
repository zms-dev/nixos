# ide — IDE settings configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.ide = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.ide = {
          enabled = true;
        };
      };
  };
}
