# trusted-egress — trusted egress subnet configuration (10.50.100.0/24)
{ den, ... }:
{
  den.aspects.networking._.subnets._.trusted-egress = {
    includes = [ den.aspects.networking._.subnets ];

    nixos =
      { lib, ... }:
      {
        networking.subnets.trusted-egress = {
          subnet = "10.50.100.0";
          prefixLength = 24;
          gateway = "10.50.100.1";
          namedAddresses = {
            flood = "10.50.100.2";
            prowlarr = "10.50.100.3";
            radarr = "10.50.100.4";
            sonarr = "10.50.100.5";
            lidarr = "10.50.100.6";
            readarr = "10.50.100.7";
            bazarr = "10.50.100.8";
            nzbhydra = "10.50.100.9";
            autobrr = "10.50.100.10";
            buildarr = "10.50.100.11";
            recyclarr = "10.50.100.12";
            tdarr = "10.50.100.13";
          };
        };
      };
  };
}
