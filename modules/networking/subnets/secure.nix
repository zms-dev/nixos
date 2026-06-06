{ den, ... }:
{
  den.aspects.networking._.subnets._.secure = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.secure = {
          subnet = "10.100.0.0";
          prefixLength = 24;
          gateway = "10.100.0.1";
          namedAddresses = { };
        };
      };
  };
}
