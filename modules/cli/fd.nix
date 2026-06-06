{ ... }:
{
  den.aspects.cli._.fd = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.fd ];
      };
  };
}
