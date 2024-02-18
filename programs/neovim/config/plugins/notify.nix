{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.notify = {
    enable = true;
  };
}
