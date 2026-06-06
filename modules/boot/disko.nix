{ inputs, ... }:
{
  den.aspects.boot._.disko = {
    nixos =
      { ... }:
      {
        imports = [ inputs.disko.nixosModules.disko ];
      };
  };

  flake-file.inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
