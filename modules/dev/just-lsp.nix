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
