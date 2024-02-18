{config, pkgs, ...}: 

{
  home.packages = with pkgs; [
    wlr-randr
  ];
  
  #wayland.windowManager.hyprland.settings.monitor = [
  #  "HDMI-A-1,3840x2160@119.88000,0x0,1"
  #  "HDMI-A-1,3840x2160@60,0x0,1"
  #  "HDMI-A-1,3840x2160@119,0x0,1"
  #];

  wayland.windowManager.hyprland.settings.exec = [
    "${pkgs.wlr-randr}/bin/wlr-randr --output HDMI-A-1 --mode 3840x2160@119.879997"
  ];
}
