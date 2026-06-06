{ den, ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.explorer = {
    includes = [
      den.aspects.dev._.sqlite
      den.aspects.cli._.neovim._.plugins._.snacks._.picker
    ];

    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks.settings.explorer = {
          enabled = true;
          replace_netrw = true;
        };

        programs.nixvim.plugins.snacks.settings.picker.sources.explorer = {
          hidden = true;
        };

        programs.nixvim.keymaps = [
          {
            key = "<leader>e";
            action = "<cmd>lua Snacks.explorer()<cr>";
            options = {
              desc = "File Explorer";
            };
          }
        ];
      };
  };
}
