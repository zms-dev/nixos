{config, lib, pkgs, ... }:

{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
    WebDevIconsUnicodeGlyphDoubleWidth = 1;
    WebDevIconsNerdTreeAfterGlyphPadding = "  ";
  };
}
