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
