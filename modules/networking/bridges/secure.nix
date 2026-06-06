{ den, ... }:
{
  den.aspects.networking._.bridges._.secure = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-secure.interfaces = [ ];
      };
  };
}
