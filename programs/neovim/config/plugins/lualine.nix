{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    iconsEnabled = true;
    globalstatus = true;
  };
}
