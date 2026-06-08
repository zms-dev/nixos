# untrusted-ingress — network bridge interface configuration for untrusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.untrusted-ingress = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-untr-in.interfaces = [ ];
      };
  };
}
