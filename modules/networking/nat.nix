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
