{ ... }:
{
  den.aspects.cli._.gemini-cli._.privacy = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.privacy = {
          usageStatisticsEnabled = false;
        };
      };
  };
}
