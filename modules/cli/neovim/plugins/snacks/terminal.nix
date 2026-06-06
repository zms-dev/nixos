{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.terminal = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks.settings.terminal = {
          enabled = true;
          win = {
            style = "terminal";
          };
        };

        programs.nixvim.keymaps = [
          {
            key = "<c-/>";
            action = "<cmd>lua Snacks.terminal()<cr>";
            options = {
              desc = "Toggle Terminal";
            };
          }
        ];
      };
  };
}
