# isolated — network bridge interface configuration for isolated subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.isolated = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-isolated.interfaces = [ ];
      };
  };
}
