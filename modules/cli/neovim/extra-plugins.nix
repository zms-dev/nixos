# neovim: extra-plugins — raw plugin packages not managed by nixvim's plugin system
{ ... }:
{
  den.aspects.cli._.neovim._.extra-plugins = {
    homeManager =
      { ... }:
      {
        programs.nixvim.extraPlugins = [ ];
      };
  };
}
