{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.input = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks.settings.input = {
          enabled = true;
          icon = " ";
          icon_hl = "SnacksInputIcon";
          icon_pos = "left";
          prompt_pos = "title";
          win = {
            style = "input";
          };
          expand = true;
        };
      };
  };
}
