# NuPhy Kick75 — 75% wireless mechanical keyboard; VIA udev rules for HID access (VID 19f5)
{ den, ... }:
{
  den.aspects.hw._.nuphy-kick75 = {
    includes = [ den.aspects.hw._.rgb ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.via ];
        services.udev.extraRules = ''
          # Kick75 IO (normal mode)
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="1026", TAG+="uaccess"
          # Kick75 Upgrader (bootloader mode)
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="0720", TAG+="uaccess"
        '';
      };
  };
}
