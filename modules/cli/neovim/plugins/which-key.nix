{ den, ... }:
{
  den.aspects.cli._.neovim._.plugins._.which-key = {
    includes = [
      den.aspects.cli._.neovim._.plugins._.mini._.icons
    ];

    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.which-key = {
          enable = true;
          lazyLoad = {
            enable = true;
            settings.event = "DeferredUIEnter";
          };
          settings = {
            win = {
              border = "rounded";
            };
          };
        };
      };
  };
}
