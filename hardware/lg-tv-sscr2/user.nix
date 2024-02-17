{config, pkgs, ...}: 

{
  wayland.windowManager.hyprland.settings.monitor = [
    "HDMI-A-1,3840x2160@119.88000,0x0,1"
    #"HDMI-A-1,3840x2160@100,0x0,1"
  ];
}
