{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ../../hardware/lg-tv-sscr2/user.nix
    ../../programs/firefox/default.nix
    ../../programs/git/default.nix
    ../../programs/home-manager/default.nix
    ../../programs/hyprland/default.nix
    ../../programs/kitty/default.nix
    ../../programs/neovim/testing.nix
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
    swww
  ];

  home.sessionVariables = {
    TERM = "kitty";
    EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;
  #colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
  #colorScheme = inputs.nix-colors.colorSchemes.onedark;
  #colorScheme = inputs.nix-colors.colorSchemes.tokyodark;
  #colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;
  #colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  colorScheme = inputs.nix-colors.colorSchemes.rose-pine;

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.swww}/bin/swww init"
  ];


  programs.git.userName = "zms";
  programs.git.userEmail = "root@zms.dev";
}
