{ pkgs, ... }:
{
  den.aspects.hosts._.desktop._.boot = {
    nixos = {
      boot.loader.systemd-boot.enable = true;
      boot.loader.grub.enable = false;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.initrd.systemd.enable = true;
      boot.zfs.forceImportRoot = false;
      boot.initrd.availableKernelModules = [
        "nvme"
        "ahci"
        "xhci_pci"
        "thunderbolt"
        "usbhid"
        "uas"
        "sd_mod"
      ];
    };
  };
}
