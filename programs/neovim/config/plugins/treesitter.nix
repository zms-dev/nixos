{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    ensureInstalled = [
      "vim"
      "lua"
      "regex"
      "bash"
      "markdown"
      "markdown_inline"
      "nix"
      "zsh"
    ];
  };
}
