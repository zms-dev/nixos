# neovim: auto-commands — autoCmd event-triggered commands (autocmds)
{ ... }:
{
  den.aspects.cli._.neovim._.auto-commands = {
    homeManager =
      { ... }:
      {
        programs.nixvim.autoCmd = [ ];
      };
  };
}
