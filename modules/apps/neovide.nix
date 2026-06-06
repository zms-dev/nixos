/*
  neovide — graphical user interface client for Neovim
  https://github.com/neovide/neovide
*/
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
