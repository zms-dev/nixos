/*
  git-hooks.nix — repository pre-commit git hooks and formatting checks
  https://github.com/cachix/git-hooks.nix
*/
{ inputs, ... }:
{
  flake-file.inputs = {
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports =
    if inputs ? git-hooks-nix then
      [
        inputs.git-hooks-nix.flakeModule
      ]
    else
      [ ];

  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    if inputs ? git-hooks-nix then
      {
        pre-commit = {
          check.enable = true;
          settings = {
            install.enable = false;
            hooks = {
              nixfmt-tree-check = {
                enable = true;
                name = "nixfmt-tree";
                description = "Format Nix files using the project formatter";
                entry = "${pkgs.nixfmt-tree}/bin/treefmt";
                args = [ "--no-cache" ];
                files = "\\.nix$";
              };
            };
          };
        };
      }
    else
      { };
}
