{ ... }:
{
  den.aspects.dev._.yaml-language-server = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.yaml-language-server ];
      };
  };
}
