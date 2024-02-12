{ config, lib, pkgs, ... }:

{
  programs.yazi.enable = true;
  programs.yazi.enableZshIntegration = true;
  programs.yazi.theme = {
    status = {
      separator_open = "";
      separator_close = "";
    };
    manager = {
      border_symbol = " ";
      preview_hovered = {
        bg = "darkgray";
        underline = false;
      };
    };
  };
  programs.yazi.settings = {
    manager = {
      ratio = [2 4 4];
      sort_by = "modified";
      sort_sensitive = false;
      sort_reverse = true;
      sort_dir_first = true;
      show_hidden = true;
      show_symlink = true;
    };
    preview = {
      tab_size = 2;
      max_width = 1024;
      max_height = 1024;
      cache_dir = "";
    };
  };
}
