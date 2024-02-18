{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.fugitive = {
    enable = true;
  };
}
