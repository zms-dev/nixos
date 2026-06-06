# Samsung NVMe SSD — fstrim, smartd, nvme-cli, power-saving PS latency tuning, and I/O scheduler udev rules
{ ... }:
{
  den.aspects.hw._.samsung-ssd = {
    nixos =
      { pkgs, ... }:
      {
        services.fstrim.enable = true;
        services.smartd.enable = true;
        environment.systemPackages = [ pkgs.nvme-cli ];
        boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
        services.udev.extraRules = ''
          ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
        '';
      };
  };
}
