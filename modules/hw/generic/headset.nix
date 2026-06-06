/*
  headset — headsetcontrol udev rules and CLI for sidetone, LED, and battery reporting over USB HID
  https://github.com/Sapd/HeadsetControl
*/
{ ... }:
{
  den.aspects.hw._.headset = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.headsetcontrol ];
        services.udev.packages = [ pkgs.headsetcontrol ];
      };
  };
}
