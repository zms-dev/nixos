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
