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
