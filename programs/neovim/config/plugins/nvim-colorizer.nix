{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.nvim-colorizer = {
    enable = true;
  };
}
