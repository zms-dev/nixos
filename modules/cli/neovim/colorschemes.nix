# neovim: colorschemes — active colorscheme selection and colorscheme plugin definitions
{ ... }:
{
  den.aspects.cli._.neovim._.colorschemes = {
    homeManager =
      { ... }:
      {
        programs.nixvim.colorscheme = null;
        programs.nixvim.colorschemes = { };
      };
  };
}
