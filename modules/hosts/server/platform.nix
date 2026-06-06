{ ... }:
{
  den.aspects.hosts._.server._.platform = {
    nixos =
      { lib, ... }:
      {
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

        virtualisation.vmVariant.virtualisation.sharedDirectories.global-mnt = {
          source = "/tmp/vm-server-mnt";
          target = "/mnt";
          securityModel = "mapped-xattr";
        };

        virtualisation.vmVariant.systemd.tmpfiles.rules = [
          "d /mnt/rtorrent 0755 root root - -"
          "d /mnt/flood 0755 root root - -"
        ];
      };
  };
}
