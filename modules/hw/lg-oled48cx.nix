/*
  lg-oled48cx — LG OLED48CX monitor integration using ddcutil for DDC/CI brightness/input control
  https://github.com/rockowitz/ddcutil
*/
{ ... }:
{
  den.aspects.hw._.lg-oled48cx = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.ddcutil ];
        services.udev.packages = [ pkgs.ddcutil ];
        boot.kernelModules = [ "i2c-dev" ];
      };

    provides.to-users.homeManager =
      { ... }:
      {
        programs.niri.settings.outputs."HDMI-A-2" = {
          mode = {
            width = 3840;
            height = 2160;
            refresh = 119.88;
          };
          scale = 1.5;
        };
      };
  };
}
