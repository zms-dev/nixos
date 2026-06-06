{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks._.scope = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks.settings.scope = {
          enabled = true;
          min_size = 2;
          cursor = true;
          edge = true;
          siblings = false;
          debounce = 30;
        };
      };
  };
}
