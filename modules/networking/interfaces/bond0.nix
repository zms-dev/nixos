# bond0 — network interface setup for bond0 with DHCP enabled
{ den, ... }:
{
  den.aspects.networking._.interfaces._.bond0 = {
    includes = [ den.aspects.networking._.bonds._.bond0 ];

    nixos =
      { lib, ... }:
      {
        networking.interfaces.bond0 = {
          useDHCP = true;
        };
      };
  };
}
