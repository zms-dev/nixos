{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
  };
}
