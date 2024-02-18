{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.project-nvim.enable = true;
  };
}
