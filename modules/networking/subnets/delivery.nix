# delivery — delivery subnet configuration
{ den, ... }:
{
  den.aspects.networking._.subnets._.delivery = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.delivery = {
          subnet = "10.30.0.0";
          prefixLength = 24;
          gateway = "10.30.0.1";
          namedAddresses = { };
        };
      };
  };
}
