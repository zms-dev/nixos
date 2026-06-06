# neovim: globals — vim.g global variables (leader key, provider flags, plugin globals)
{ ... }:
{
  den.aspects.cli._.neovim._.globals = {
    homeManager =
      { ... }:
      {
        programs.nixvim.globals = {
          mapleader = " ";
          maplocalleader = " ";
        };
      };
  };
}
