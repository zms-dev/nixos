/*
  lidarr — music collection manager for Usenet and BitTorrent users
  https://lidarr.audio
*/
{ den, ... }:
{
  den.aspects.containers._.lidarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.lidarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8686;
            description = "Lidarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.lidarr = 8686;
          containers.lidarr =
            let
              port = config.containerPorts.lidarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.lidarr;
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
              toContainer = config.containers.lidarr;
              toPort = config.containerPorts.lidarr.port;
            }
          ];
        };
      };
  };
}
