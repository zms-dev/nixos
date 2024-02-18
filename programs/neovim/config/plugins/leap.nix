{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.leap = {
    enable = true;
  };
}
