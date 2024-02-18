{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = true;
  };
}
