{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.bufdelete = {
    homeManager =
      { ... }:
      {
        programs.nixvim.keymaps = [
          {
            key = "<leader>bd";
            action = "<cmd>lua Snacks.bufdelete()<cr>";
            options = {
              desc = "Delete Buffer";
            };
          }
        ];
      };
  };
}
