{ ... }:
{
  den.aspects.dev._.nixfmt = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nixfmt ];
      };
  };
}
