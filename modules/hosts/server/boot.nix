{ lib, ... }:
{
  den.aspects.hosts._.server._.boot = {
    nixos = {
      # Minimal dummy bootloader to satisfy NixOS system evaluation
      boot.loader.grub.enable = lib.mkDefault true;
      boot.loader.grub.device = lib.mkDefault "nodev";
    };
  };
}
