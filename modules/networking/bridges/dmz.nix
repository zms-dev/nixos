# dmz — network bridge interface configuration for DMZ subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.dmz = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-dmz.interfaces = [ ];
      };
  };
}
