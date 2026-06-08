# trusted-egress — network bridge interface configuration for trusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.trusted-egress = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-trust-eg.interfaces = [ ];
      };
  };
}
