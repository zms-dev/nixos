# backend — network bridge interface configuration for backend subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.backend = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-backend.interfaces = [ ];
      };
  };
}
