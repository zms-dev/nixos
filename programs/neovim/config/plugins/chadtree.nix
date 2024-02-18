{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.chadtree = {
    enable = true;
  };
}
