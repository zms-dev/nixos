# neovim: performance — runtime tuning; enables Lua bytecode compilation via impatient.nvim/lazy loading
{ ... }:
{
  den.aspects.cli._.neovim._.performance = {
    homeManager =
      { ... }:
      {
        programs.nixvim.performance = {
          byteCompileLua.enable = true;
        };
      };
  };
}
