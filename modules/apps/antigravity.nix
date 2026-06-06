/*
  antigravity — Google Antigravity Suite
  https://github.com/zms-dev/antigravity-flake
*/
{ den, ... }:
{
  den.aspects.apps._.antigravity = {
    includes = [ den.aspects.dev._.antigravity ];

    homeManager =
      { ... }:
      {
        programs.antigravity.gui = {
          enable = true;
        };
      };
  };
}
