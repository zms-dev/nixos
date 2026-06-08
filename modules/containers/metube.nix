/*
  metube — self-hosted YouTube downloader front-end using yt-dlp
  https://github.com/alexta69/metube
*/
{ den, ... }:
{
  den.aspects.containers._.metube = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.metube = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8081;
            description = "MeTube Web UI port";
          };
        };

        config = {
          networking.hostPorts.metube = 8081;
          containers.metube =
            let
              port = config.containerPorts.metube.port;
              net = config.networking.subnets.untrusted-egress;
              containerIp = net.namedAddresses.metube;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-untr-eg.name;
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
              toContainer = config.containers.metube;
              toPort = config.containerPorts.metube.port;
            }
          ];
        };
      };
  };
}
