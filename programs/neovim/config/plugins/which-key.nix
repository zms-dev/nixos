{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.which-key = {
    enable = true;
  };
}
