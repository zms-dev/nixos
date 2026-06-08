/*
  prowlarr — indexer manager for Usenet and BitTorrent users
  https://prowlarr.com
*/
{ den, ... }:
{
  den.aspects.containers._.prowlarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.prowlarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 9696;
            description = "Prowlarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.prowlarr = 9696;
          containers.prowlarr =
            let
              port = config.containerPorts.prowlarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.prowlarr;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-trust-eg.name;
              localAddress = "${containerIp}/${toString net.prefixLength}";
              forwardPorts = [ ];
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
                  networking.firewall.allowedTCPPorts = [ port ];
                };
            };

          networking.zones.trusted-ingress.forwardRules = [
            {
              toContainer = config.containers.prowlarr;
              toPort = config.containerPorts.prowlarr.port;
            }
          ];
        };
      };
  };
}
