{ ... }:
{
  den.aspects.hosts._.desktop._.mounts = {
    nixos = {
      fileSystems."/projects" = {
        device = "/dev/disk/by-uuid/805F-4BA7";
        fsType = "exfat";
        options = [
          "uid=1000"
          "gid=1000"
          "umask=0022"
          "nofail"
        ];
      };
    };
  };
}
