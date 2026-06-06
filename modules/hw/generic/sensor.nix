/*
  sensor — lm_sensors for hardware temperature and voltage monitoring
  https://github.com/lm-sensors/lm-sensors
*/
{ ... }:
{
  den.aspects.hw._.sensor = {
    nixos =
      { pkgs, ... }:
      {
        hardware.sensor.hddtemp.enable = false;
        environment.systemPackages = [ pkgs.lm_sensors ];
      };
  };
}
