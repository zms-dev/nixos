/*
  bluetooth — kernel Bluetooth stack with power-on-boot and blueman GUI manager
  https://www.bluez.org
*/
{ ... }:
{
  den.aspects.hw._.bluetooth = {
    nixos =
      { pkgs, ... }:
      {
        hardware.bluetooth.enable = true;
        hardware.bluetooth.powerOnBoot = true;
        services.blueman.enable = true;
        environment.systemPackages = [ pkgs.blueman ];
      };
  };
}
