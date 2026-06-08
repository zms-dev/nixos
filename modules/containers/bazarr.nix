/*
  bazarr — subtitle downloader companion for Sonarr and Radarr
  https://www.bazarr.media
*/
{ den, ... }:
{
  den.aspects.containers._.bazarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.bazarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 6767;
            description = "Bazarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.bazarr = 6767;
          containers.bazarr =
            let
              port = config.containerPorts.bazarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.bazarr;
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
              toContainer = config.containers.bazarr;
              toPort = config.containerPorts.bazarr.port;
            }
          ];
        };
      };
  };
}
