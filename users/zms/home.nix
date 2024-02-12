{ config, lib, pkgs, ... }:

{
  imports = [
    ../../hardware/lg-tv-sscr2/user.nix
    ../../programs/firefox/default.nix
    ../../programs/git/default.nix
    ../../programs/home-manager/default.nix
    ../../programs/hyprland/default.nix
    ../../programs/kitty/default.nix
    ../../programs/neovim/default.nix
    ../../programs/rofi/default.nix
    ../../programs/starship/default.nix
    ../../programs/tmux/default.nix
    ../../programs/waybar/default.nix
    ../../programs/yazi/default.nix
    ../../programs/zsh/default.nix
  ];
  home.username = "zms";
  home.homeDirectory = "/home/zms";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    # nerdfonts
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    font-awesome
  ];
  home.sessionVariables = {
    TERM = "kitty";
    EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };

  programs.git.userName = "zms";
  programs.git.userEmail = "root@zms.dev";
}
