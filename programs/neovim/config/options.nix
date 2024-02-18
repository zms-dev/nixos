{config, lib, pkgs, ... }:

{
  programs.nixvim.options = {
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2;        # Tab width should be 2
    smartindent = true;
    expandtab = true;
    clipboard = "unnamedplus";
  };
}
