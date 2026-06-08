/*
  seerr — request management and media discovery tool for Jellyfin/Plex (Overseerr fork)
  https://github.com/fallenbagel/jellyseerr
*/
{ den, ... }:
{
  den.aspects.containers._.seerr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.seerr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 5055;
            description = "Jellyseerr Web UI port";
          };
        };

        config = {
          networking.hostPorts.seerr = 5055;
          containers.seerr =
            let
              port = config.containerPorts.seerr.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.seerr;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-trust-in.name;
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
              toContainer = config.containers.seerr;
              toPort = config.containerPorts.seerr.port;
            }
          ];
        };
      };
  };
}
