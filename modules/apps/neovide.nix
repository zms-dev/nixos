{ den, ... }:
{
  den.aspects.apps._.neovide = {
    includes = [
      den.aspects.fonts._.jetbrains-mono
    ];

    homeManager =
      { ... }:
      {
        programs.neovide = {
          enable = true;
        };
      };
  };
}
