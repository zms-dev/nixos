{ config, lib, pkgs, ... }:

{
  programs.kitty.enable = true;
  programs.kitty.font = {
    package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
    name = "Iosevka Nerd Font Mono";
    size = 18;
  };
  programs.kitty.settings.open_url_with = "chromium";
  programs.kitty.settings.copy_on_select = "clipboard";
  programs.kitty.settings.tab_bar_edge = "top";
  programs.kitty.settings.enable_audio_bell = "no";
  programs.kitty.theme = "Nord";
}
