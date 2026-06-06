{ den, ... }:
{
  den.aspects.networking._.bonds._.bond0 = {
    nixos =
      { lib, ... }:
      {
        networking.bonds.bond0 = {
          driverOptions.mode = "802.3ad";
        };
      };
  };
}
