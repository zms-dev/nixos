{ den, ... }:
{
  den.aspects.networking._.subnets._.untrusted = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.untrusted = {
          subnet = "10.1.0.0";
          prefixLength = 24;
          gateway = "10.1.0.1";
          namedAddresses = {
            rtorrent = "10.1.0.2";
          };
        };
      };
  };
}
