{config, lib, pkgs, ... }:

{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
  };
}
