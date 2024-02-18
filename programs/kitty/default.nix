{ config, lib, pkgs, ... }:

let
  inherit (config.colorScheme) palette;
in
{
  programs.kitty.enable = true;
  programs.kitty.font = {
    package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
    name = "Iosevka Nerd Font";
    size = 18;
  };
  programs.kitty.settings = {
    open_url_with = "chromium";
    copy_on_select = "clipboard";
    tab_bar_edge = "top";
    enable_audio_bell = "no";
    scrollback_lines = 4000;
    scrollback_pager_history_size = 2048;
    window_padding_width = 0;
    foreground = "#${palette.base05}";
    background = "#${palette.base00}";
    selection_background = "#${palette.base05}";
    selection_foreground = "#${palette.base00}";
    url_color = "#${palette.base04}";
    cursor = "#${palette.base05}";
    active_border_color = "#${palette.base03}";
    inactive_border_color = "#${palette.base01}";
    active_tab_background = "#${palette.base00}";
    active_tab_foreground = "#${palette.base05}";
    inactive_tab_background = "#${palette.base01}";
    inactive_tab_foreground = "#${palette.base04}";
    tab_bar_background = "#${palette.base01}";
    color0 = "#${palette.base00}";
    color1 = "#${palette.base08}";
    color2 = "#${palette.base0B}";
    color3 = "#${palette.base0A}";
    color4 = "#${palette.base0D}";
    color5 = "#${palette.base0E}";
    color6 = "#${palette.base0C}";
    color7 = "#${palette.base05}";
    color8 = "#${palette.base03}";
    color9 = "#${palette.base08}";
    color10 = "#${palette.base0B}";
    color11 = "#${palette.base0A}";
    color12 = "#${palette.base0D}";
    color13 = "#${palette.base0E}";
    color14 = "#${palette.base0C}";
    color15 = "#${palette.base07}";
    color16 = "#${palette.base09}";
    color17 = "#${palette.base0F}";
    color18 = "#${palette.base01}";
    color19 = "#${palette.base02}";
    color20 = "#${palette.base04}";
    color21 = "#${palette.base06}";
  };
  #programs.kitty.theme = "Nord";
}
