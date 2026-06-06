{ den, ... }:
{
  den.aspects.networking._.subnets._.backend = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.backend = {
          subnet = "10.50.0.0";
          prefixLength = 24;
          gateway = "10.50.0.1";
          namedAddresses = {
            flood = "10.50.0.2";
          };
        };
      };
  };
}
