{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.project-nvim = {
    enable = true;
    detectionMethods = ["lsp" "pattern"];
    patterns = [
      ".git"
      "package.json"
      "Makefile"
      "rust-toolchain.toml"
      "Cargo.toml"
      "flake.nix"
    ];
  };
}
