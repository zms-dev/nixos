# neovim: file-types — filetype detection and per-filetype option overrides
{ ... }:
{
  den.aspects.cli._.neovim._.file-types = {
    homeManager =
      { ... }:
      {
        programs.nixvim.fileType = { };
      };
  };
}
