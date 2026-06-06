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
