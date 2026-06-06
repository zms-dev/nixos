/*
  psmisc — system utilities using the proc filesystem, such as killall, fuser, and pstree
  https://gitlab.com/psmisc/psmisc
*/
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
