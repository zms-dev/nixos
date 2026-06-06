/*
  manix — fast CLI documentation searcher for nixpkgs, NixOS options, and home-manager options
  https://github.com/nix-community/manix
*/
{ inputs, ... }:
{
  den.aspects.dev._.manix = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.manix
          pkgs.man-pages
          pkgs.man-pages-posix
        ];
      };

    nixos =
      { ... }:
      {
        nix.nixPath = [
          "home-manager=${inputs.home-manager}"
          "nixpkgs=${inputs.nixpkgs}"
        ];
      };
  };
}
