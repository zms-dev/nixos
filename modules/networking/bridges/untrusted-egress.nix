# untrusted-egress — network bridge interface configuration for untrusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.bridges._.untrusted-egress = {
    nixos =
      { lib, ... }:
      {
        networking.bridges.br-untr-eg.interfaces = [ ];
      };
  };
}
