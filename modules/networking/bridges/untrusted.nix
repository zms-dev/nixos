{ den, ... }:
{
  den.aspects.networking._.bridges._.untrusted = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-untrusted.interfaces = [ ];
      };
  };
}
