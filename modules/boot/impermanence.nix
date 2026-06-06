{ inputs, ... }:
{
  den.aspects.boot._.impermanence = {
    nixos =
      { ... }:
      {
        imports = [ inputs.impermanence.nixosModules.impermanence ];
      };
  };

  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
}
