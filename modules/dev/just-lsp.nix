/*
  just-lsp — Language Server Protocol (LSP) server for justfiles
  https://github.com/skydiver/just-lsp
*/
{ ... }:
{
  den.aspects.dev._.just-lsp = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.just-lsp ];
      };
  };
}
