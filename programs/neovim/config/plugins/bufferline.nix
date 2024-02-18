{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.bufferline = {
    enable = true;
  };
}
