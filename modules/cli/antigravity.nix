/*
  antigravity — Google Antigravity Suite
  https://github.com/zms-dev/antigravity-flake
*/
{ den, ... }:
{
  den.aspects.cli._.antigravity = {
    includes = [ den.aspects.dev._.antigravity ];

    homeManager =
      { ... }:
      {
        programs.antigravity.cli = {
          enable = true;
          settings = {
            trustedWorkspaces = [
              "/projects"
              "/etc/nixos"
            ];
          };
        };
      };
  };
}
