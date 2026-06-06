{ den, ... }:
{
  den.aspects.hosts._.server._.disks = {
    includes = [ den.aspects.boot._.disko ];

    nixos = {
      disko.devices = {
        disk.dummy = {
          device = "/dev/vda";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
