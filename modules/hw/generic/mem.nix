# memory — kernel VM tuning for large-RAM desktops and zram swap (zstd compression, 25% of RAM)
{ ... }:
{
  den.aspects.hw._.mem = {
    nixos =
      { ... }:
      {
        boot.kernel.sysctl = {
          "vm.swappiness" = 10;
          "vm.vfs_cache_pressure" = 50;
          "vm.page-cluster" = 0;
          # Absolute dirty limits beat ratios on large RAM — 20% of 64GB = 12GB stall
          "vm.dirty_background_bytes" = 67108864; # 64 MB — start background writeback
          "vm.dirty_bytes" = 1073741824; # 1 GB — hard throttle limit
        };

        zramSwap = {
          enable = true;
          algorithm = "zstd";
          memoryPercent = 25;
        };
      };
  };
}
