{config, lib, pkgs, ... }:

{
  programs.nixvim.colorschemes.tokyonight = {
    enable = true;
    style = "night";
    transparent = false;
  };
}
