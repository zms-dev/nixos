# nat — NAT (Network Address Translation) configuration
{ den, ... }:
{
  den.aspects.networking._.nat = {
    nixos =
      { lib, ... }:
      {
        networking.nat.enable = true;
      };
  };
}
