# neovim: auto-groups — named augroups for organizing autocmds
{ ... }:
{
  den.aspects.cli._.neovim._.auto-groups = {
    homeManager =
      { ... }:
      {
        programs.nixvim.autoGroups = {
          filetypes = { };
        };
      };
  };
}
