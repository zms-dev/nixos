# trusted-ingress — trusted ingress subnet configuration (10.10.100.0/24)
{ den, ... }:
{
  den.aspects.networking._.subnets._.trusted-ingress = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.trusted-ingress = {
          subnet = "10.10.100.0";
          prefixLength = 24;
          gateway = "10.10.100.1";
          namedAddresses = {
            seerr = "10.10.100.2";
            jellyfin = "10.10.100.3";
            wikimedia = "10.10.100.4";
            home-assistant = "10.10.100.5";
            homepage = "10.10.100.6";
            linkding = "10.10.100.7";
            opencode = "10.10.100.8";
            forgejo = "10.10.100.9";
            caddy = "10.10.100.10";
          };
        };
      };
  };
}
