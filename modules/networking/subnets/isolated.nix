# isolated — isolated subnet configuration (10.100.100.0/24)
{ den, ... }:
{
  den.aspects.networking._.subnets._.isolated = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.isolated = {
          subnet = "10.100.100.0";
          prefixLength = 24;
          gateway = "10.100.100.1";
          namedAddresses = {
            pi-hole = "10.100.100.2";
            unpackerr = "10.100.100.3";
          };
        };
      };
  };
}
