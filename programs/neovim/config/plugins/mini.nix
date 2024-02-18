{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      surround = {};
      trailspace = {};
      splitjoin = {};
      pairs = {};
      indentscope = {};
    };
  };
}
