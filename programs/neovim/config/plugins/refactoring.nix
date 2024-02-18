{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.refactoring = {
    enable = true;
  };
}
