/*
  unpackerr — automated archive extraction daemon for downloader clients
  https://github.com/davidnewhall/unpackerr
*/
{ den, ... }:
{
  den.aspects.containers._.unpackerr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-isolated
    ];

    provides.to-hosts.nixos =
      { config, ... }:
      {
        config = {
          containers.unpackerr =
            let
              net = config.networking.subnets.isolated;
              containerIp = net.namedAddresses.unpackerr;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-isolated.name;
              localAddress = "${containerIp}/${toString net.prefixLength}";
              bindMounts = {
                "/etc/resolv.conf" = {
                  hostPath = "/run/systemd/resolve/resolv.conf";
                  isReadOnly = true;
                };
              };
              config =
                { ... }:
                {
                  system.stateVersion = "26.05";
                  networking.enableIPv6 = false;
                  networking.defaultGateway = net.gateway;
                  networking.extraHosts = extraHosts;
                };
            };
        };
      };
  };
}
