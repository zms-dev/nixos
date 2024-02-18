{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.illuminate = {
    enable = true;
  };
}
