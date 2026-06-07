# delivery — network bridge interface configuration for delivery subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.delivery = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-delivery.interfaces = [ ];
      };
  };
}
