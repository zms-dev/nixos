{ den, ... }:
{
  den.aspects.networking._.subnets._.dmz = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.dmz = {
          subnet = "10.10.0.0";
          prefixLength = 24;
          gateway = "10.10.0.1";
          namedAddresses = { };
        };
      };
  };
}
