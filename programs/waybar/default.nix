{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };

  programs.waybar.settings = {
    "bar" = {
      layer = "top";
      position = "top";
      height = 24;
      width = null;
      spacing = 16;
      margin = null;
      margin-top = 16;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      fixed-center = true;
      ipc = true;

      modules-left = ["hyprland/workspaces"];
      modules-center = [];
      modules-right = [
        "network"
        "cpu"
        "memory"
        "clock"
        "tray"
      ];

      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        sort-by-number = true;
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        all-outputs = true;
        active-only = false;
        format-icons = {
          "1" = "󰪃";
          "2" = "󰩾";
          "3" = "󰪁";
          "4" = "󰪂";
          "5" = "󰪇";
          "6" = "󰪆";
          "7" = "󰩽";
          "8" = "󰩿";
          "9" = "󰪄";
          "10" = "󰪈";
        };
        persistent_workspaces = {
          "*" = 5;
        };
      };
    };
  };


  #programs.waybar.style = pkgs.lib.readFile ./default.css;
  xdg.configFile."waybar/style.css".source = pkgs.runCommand "style" {buildInputs = [pkgs.sass];} ''
    ${pkgs.sass}/bin/scss \
        --sourcemap=none \
        --no-cache \
        --style compressed \
        --default-encoding utf-8 \
        ${./default.scss} > $out 
  '';

  wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];
}
