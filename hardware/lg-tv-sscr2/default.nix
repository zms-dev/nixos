{config, pkgs, ...}: 

{
  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
  ];

  #environment.systemPackages = with pkgs; [
  #  wlr-randr
  #];
}
