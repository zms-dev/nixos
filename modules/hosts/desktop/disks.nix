# disks — disk partitioning, LUKS encryption, and Btrfs subvolumes layout for desktop host
{ den, inputs, ... }:
{
  den.aspects.hosts._.desktop._.disks = {
    includes = [ den.aspects.boot._.disko ];

    nixos = {
      zramSwap.enable = true;
      zramSwap.priority = 100;

      disko.devices = {
        disk.main = {
          device = "/dev/nvme3n1";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                label = "boot";
                name = "ESP";
                size = "1G";
                type = "EF00";
                priority = 1;
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "fmask=0022"
                    "dmask=0022"
                  ];
                };
              };
              luks = {
                size = "100%";
                label = "luks";
                priority = 2;
                content = {
                  type = "luks";
                  name = "cryptroot";
                  # Standard disko automation: use a file if present
                  passwordFile = "/tmp/luks.key";
                  extraOpenArgs = [
                    "--allow-discards"
                    "--perf-no_read_workqueue"
                    "--perf-no_write_workqueue"
                  ];
                  content = {
                    type = "btrfs";
                    extraArgs = [
                      "-L"
                      "nixos"
                      "-f"
                    ];
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [
                          "subvol=root"
                          "compress=zstd:3"
                          "noatime"
                          "ssd"
                          "discard=async"
                          "space_cache=v2"
                          "commit=120"
                        ];
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = [
                          "subvol=home"
                          "compress=zstd:3"
                          "noatime"
                          "ssd"
                          "discard=async"
                          "space_cache=v2"
                          "commit=120"
                          "autodefrag"
                        ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "subvol=nix"
                          "compress=zstd:3"
                          "noatime"
                          "ssd"
                          "discard=async"
                          "space_cache=v2"
                          "commit=120"
                        ];
                      };
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = [
                          "subvol=persist"
                          "compress=zstd:3"
                          "noatime"
                          "ssd"
                          "discard=async"
                          "space_cache=v2"
                          "commit=120"
                        ];
                      };
                      "/log" = {
                        mountpoint = "/var/log";
                        mountOptions = [
                          "subvol=log"
                          "compress=zstd:3"
                          "noatime"
                          "ssd"
                          "discard=async"
                          "space_cache=v2"
                          "commit=120"
                        ];
                      };
                      "/swap" = {
                        mountpoint = "/swap";
                        swap.swapfile.size = "8G";
                        swap.swapfile.priority = -2;
                        mountOptions = [
                          "subvol=swap"
                          "noatime"
                          "nodatacow"
                          "nodatasum"
                        ];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
