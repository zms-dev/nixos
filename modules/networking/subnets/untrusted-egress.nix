# untrusted-egress — untrusted egress subnet configuration (10.50.1.0/24)
{ den, ... }:
{
  den.aspects.networking._.subnets._.untrusted-egress = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.untrusted-egress = {
          subnet = "10.50.1.0";
          prefixLength = 24;
          gateway = "10.50.1.1";
          namedAddresses = {
            nzbget = "10.50.1.2";
            metube = "10.50.1.3";
            speedtest-tracker = "10.50.1.4";
          };
        };
      };
  };
}
