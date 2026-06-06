/*
  RGB — OpenRGB service and CLI for cross-vendor LED control over USB/I2C/SMBus
  https://gitlab.com/CalcProgrammer1/OpenRGB
*/
{ ... }:
{
  den.aspects.hw._.rgb = {
    nixos =
      { pkgs, ... }:
      {
        services.hardware.openrgb.enable = true;
        environment.systemPackages = [ pkgs.openrgb ];
      };
  };
}
