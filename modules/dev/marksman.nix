/*
  marksman — Language Server Protocol (LSP) server for Markdown
  https://github.com/artempyanykh/marksman
*/
{ ... }:
{
  den.aspects.dev._.marksman = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.marksman ];
      };
  };
}
