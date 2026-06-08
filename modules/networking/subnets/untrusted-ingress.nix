# untrusted-ingress — untrusted ingress subnet configuration (10.10.1.0/24)
{ den, ... }:
{
  den.aspects.networking._.subnets._.untrusted-ingress = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.untrusted-ingress = {
          subnet = "10.10.1.0";
          prefixLength = 24;
          gateway = "10.10.1.1";
          namedAddresses = {
            rtorrent = "10.10.1.2";
          };
        };
      };
  };
}
