# networking — network configuration, bond interfaces, and NAT settings for server host
{ den, ... }:
{
  den.aspects.hosts._.server._.networking = {
    includes = [
      den.aspects.services._.resolved
      den.aspects.networking._.nat
      den.aspects.networking._.networkmanager
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.bond0
      den.aspects.networking._.interfaces._.br-untrusted-ingress
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.interfaces._.br-isolated
      den.aspects.networking._.zones._.wan
      den.aspects.networking._.zones._.isolated
      den.aspects.networking._.zones._.trusted-ingress
      den.aspects.networking._.zones._.trusted-egress
      den.aspects.networking._.zones._.untrusted-ingress
      den.aspects.networking._.zones._.untrusted-egress
    ];

    nixos =
      { config, lib, ... }:
      {
        networking = {
          hostName = "server";
          bonds.bond0.interfaces = [
            "enp3s0f0"
            "enp3s0f1"
          ];
          nat.externalInterface = "bond0";
        };

        virtualisation.vmVariant = {
          virtualisation.diskSize = 8192;
          networking.bonds = lib.mkForce { };
          networking.interfaces.bond0 = lib.mkForce { };
          networking.interfaces.eth0.useDHCP = true;
          networking.nat.externalInterface = lib.mkForce "eth0";
        };
      };
  };
}
