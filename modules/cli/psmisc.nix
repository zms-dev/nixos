{ ... }:
{
  den.aspects.cli._.psmisc = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.psmisc ];
      };
  };
}
