{ ... }:
{
  den.aspects.cli._.gemini-cli._.general = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.settings.general = {
          preferredEditor = "nvim";
          previewFeatures = true;
          # vimMode = true;
        };
      };
  };
}
