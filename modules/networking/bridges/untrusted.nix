# untrusted — network bridge interface configuration for untrusted subnet
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
