# privacy — privacy settings configuration for gemini-cli
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
