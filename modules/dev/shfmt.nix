{ ... }:
{
  den.aspects.dev._.shfmt = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.shfmt ];
      };
  };
}
