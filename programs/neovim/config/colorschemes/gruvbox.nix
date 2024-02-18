{config, lib, pkgs, ... }:

{
  programs.nixvim.colorschemes.gruvbox = {
    enable = true;
    settings = {
      transparent_bg = true;
    };
  };
}
