/*
  prettier — opinionated code formatter for web development files
  https://github.com/prettier/prettier
*/
{ ... }:
{
  den.aspects.dev._.prettier = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.prettier ];
      };
  };
}
