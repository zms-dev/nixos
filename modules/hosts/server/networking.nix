# networking — network configuration, bond interfaces, and NAT settings for server host
{ den, ... }:
{
  den.aspects.hosts._.server._.networking = {
    includes = [
      den.aspects.services._.resolved
      den.aspects.networking._.nat
      den.aspects.networking._.networkmanager
      den.aspects.networking._.interfaces._.bond0
      den.aspects.networking._.interfaces._.br-backend
      den.aspects.networking._.interfaces._.br-delivery
      den.aspects.networking._.interfaces._.br-dmz
      den.aspects.networking._.interfaces._.br-secure
      den.aspects.networking._.interfaces._.br-untrusted
    ];

    nixos =
      { lib, ... }:
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
          networking.bonds = lib.mkForce { };
          networking.interfaces.bond0 = lib.mkForce { };
          networking.interfaces.eth0.useDHCP = true;
          networking.nat.externalInterface = lib.mkForce "eth0";
        };
      };
  };
}
