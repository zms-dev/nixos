{ ... }:
{
  den.aspects.dev._.lua-language-server = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.lua-language-server ];
      };
  };
}
