{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.fidget = {
    enable = true;
  };
}
