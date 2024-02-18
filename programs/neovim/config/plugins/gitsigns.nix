{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
  };
}
