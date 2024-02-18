{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.surround = {
    enable = true;
  };
}
