{ ... }:
{
  den.aspects.dev._.taplo = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.taplo ];
      };
  };
}
