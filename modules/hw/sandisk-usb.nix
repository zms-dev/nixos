# SanDisk Extreme Pro 4TB USB Drive — persistent declarative mount with systemd-automount
{ den, ... }:
{
  den.aspects.hw._.sandisk-usb = {
    includes = [
      den.aspects.services._.udisks
    ];

    nixos =
      { ... }:
      {
        fileSystems."/media/sandisk/storage" = {
          device = "/dev/disk/by-uuid/522D-E2F3";
          fsType = "exfat";
          noCheck = true;
          options = [
            "uid=1000"
            "gid=1000"
            "umask=0022"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
          ];
        };

        fileSystems."/media/sandisk/ventoy" = {
          device = "/dev/disk/by-uuid/4E21-0000";
          fsType = "exfat";
          noCheck = true;
          options = [
            "uid=1000"
            "gid=1000"
            "umask=0022"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
          ];
        };

        fileSystems."/media/sandisk/efi" = {
          device = "/dev/disk/by-uuid/626B-4255";
          fsType = "vfat";
          noCheck = true;
          options = [
            "uid=1000"
            "gid=1000"
            "umask=0022"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
          ];
        };

        fileSystems."/media/sandisk/extra" = {
          device = "/dev/disk/by-uuid/DE42-ACF4";
          fsType = "vfat";
          noCheck = true;
          options = [
            "uid=1000"
            "gid=1000"
            "umask=0022"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=60"
          ];
        };
      };
  };
}
