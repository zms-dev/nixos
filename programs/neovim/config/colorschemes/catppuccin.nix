{config, lib, pkgs, ... }:

{
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    transparentBackground = true; 
  };
}
