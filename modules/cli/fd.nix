/*
  fd — simple, fast and user-friendly alternative to find
  https://github.com/sharkdp/fd
*/
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
