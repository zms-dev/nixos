{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.trouble = {
    enable = true;
  };
}
