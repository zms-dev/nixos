/*
  sqlite — SQLite command-line tool and database engine
  https://github.com/sqlite/sqlite
*/
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
