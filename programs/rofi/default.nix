{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    plugins = [pkgs.rofi-emoji];
    terminal = "${pkgs.kitty}/bin/kitty";
  };
}
