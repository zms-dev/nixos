/*
  tree-sitter — parser generator tool and incremental parsing library
  https://github.com/tree-sitter/tree-sitter
*/
{ ... }:
{
  den.aspects.dev._.tree-sitter = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tree-sitter ];
      };
  };
}
