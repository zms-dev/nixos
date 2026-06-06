# neovim: keymaps — key mappings across modes (normal, insert, visual, terminal)
{ ... }:
{
  den.aspects.cli._.neovim._.keymaps = {
    homeManager =
      { ... }:
      {
        programs.nixvim.keymaps = [ ];

        programs.nixvim.keymapsOnEvents = { };
      };
  };
}
