{config, lib, pkgs, ... }:

{
  programs.nixvim.colorschemes.nord = {
    enable = true;
    disableBackground = true;
    borders = true;
  };
}
