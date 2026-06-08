# trusted-ingress — network bridge interface configuration for trusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.trusted-ingress = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-trust-in.interfaces = [ ];
      };
  };
}
