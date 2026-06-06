/*
  antigravity — Google Antigravity Suite
  https://github.com/zms-dev/antigravity-flake
*/
{ inputs, ... }:
{
  flake-file.inputs = {
    antigravity = {
      url = "github:zms-dev/antigravity-flake/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.dev._.antigravity = {
    homeManager =
      { ... }:
      {
        imports = [ inputs.antigravity.homeManagerModules.default ];

        programs.antigravity = {
          enable = true;
        };
      };
  };
}
