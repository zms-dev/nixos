{ ... }:
{
  den.aspects.dev._.sqlite = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.sqlite ];
      };
  };
}
