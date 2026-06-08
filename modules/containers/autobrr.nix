/*
  autobrr — IRC announce monitor and torrent downloader automation
  https://autobrr.com
*/
{ den, ... }:
{
  den.aspects.containers._.autobrr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.autobrr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 7474;
            description = "autobrr Web UI port";
          };
        };

        config = {
          networking.hostPorts.autobrr = 7474;
          containers.autobrr =
            let
              port = config.containerPorts.autobrr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.autobrr;
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
              toContainer = config.containers.autobrr;
              toPort = config.containerPorts.autobrr.port;
            }
          ];
        };
      };
  };
}
