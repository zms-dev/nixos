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
