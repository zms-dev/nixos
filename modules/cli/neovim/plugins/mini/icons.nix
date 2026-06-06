{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.mini._.icons = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.mini-icons = {
          enable = true;
          mockDevIcons = true;
          settings = {
            style = "glyph";
          };
        };
      };
  };
}
