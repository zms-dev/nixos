/*
  sonarr — TV series collection manager for Usenet and BitTorrent users
  https://sonarr.tv
*/
{ den, ... }:
{
  den.aspects.containers._.sonarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.sonarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8989;
            description = "Sonarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.sonarr = 8989;
          containers.sonarr =
            let
              port = config.containerPorts.sonarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.sonarr;
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
              toContainer = config.containers.sonarr;
              toPort = config.containerPorts.sonarr.port;
            }
          ];
        };
      };
  };
}
