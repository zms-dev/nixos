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
