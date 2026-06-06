{ den, ... }:
{
  den.aspects.cli._.neovim._.plugins._.lz-n = {
    includes = [
      den.aspects.cli._.neovim._.plugins._.mini._.icons
    ];

    homeManager =
      { ... }:
      {
        programs.nixvim.plugins.lz-n = {
          enable = true;
        };
      };
  };
}
