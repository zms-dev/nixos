{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland.settings = {
    # exec-once = [ "waybar" ];

    decoration = {
      active_opacity = 0.95;
      fullscreen_opacity = 1.0;
      inactive_opacity = 0.9;
      rounding = 10;

      blur = {
        enabled = "yes";
        passes = 4;
        size = 5;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "0x55161925";
      "col.shadow_inactive" = "0x22161925";
    };

    general = {
      allow_tearing = true;
      border_size = 2;
      "col.active_border" = "rgba(7793D1FF)";
      "col.inactive_border" = "rgb(5e6798)";
      gaps_in = 8;
      gaps_out = 16;
      layout = "dwindle";
      no_cursor_warps = true;
    };

    "$mod" = "SUPER";

    bind = [
      "$mod, M, exit"
      "$mod, Return, exec, kitty"
      "$mod SHIFT, Q, killactive, "
      "$mod, R, exec, pkill rofi || rofi -show drun"
      "$mod, B, exec, pkill waybar || waybar"

      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, right, movewindow, r"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, down, movewindow, d"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
  };
}
