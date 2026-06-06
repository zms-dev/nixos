{ ... }:
{
  den.aspects.cli._.neovim._.plugins._.snacks = {
    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.snacks = {
          enable = true;
          # lazyLoad = {
          #   enable = true;
          #   settings.event = [
          #     "DeferredUIEnter"
          #     "BufReadPost"
          #   ];
          # };
        };
      };
  };
}
