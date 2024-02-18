{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.persistence = {
    enable = true;
  };
}
