# neovim: editorconfig — built-in EditorConfig support and per-property overrides
{ ... }:
{
  den.aspects.cli._.neovim._.editorconfig = {
    homeManager =
      { ... }:
      {
        programs.nixvim.editorconfig = {
          enable = true;
          properties = { };
        };
      };
  };
}
