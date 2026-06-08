/*
  jellyfin — volunteer-built media solution/server
  https://jellyfin.org
*/
{ den, ... }:
{
  den.aspects.containers._.jellyfin = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.jellyfin = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8096;
            description = "Jellyfin Web UI port";
          };
        };

        config = {
          networking.hostPorts.jellyfin = 8096;
          containers.jellyfin =
            let
              port = config.containerPorts.jellyfin.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.jellyfin;
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
              toContainer = config.containers.jellyfin;
              toPort = config.containerPorts.jellyfin.port;
            }
          ];
        };
      };
  };
}
