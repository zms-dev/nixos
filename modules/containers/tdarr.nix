/*
  tdarr — distributed transcode orchestrator for media libraries
  https://tdarr.io
*/
{ den, ... }:
{
  den.aspects.containers._.tdarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.tdarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8265;
            description = "Tdarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.tdarr = 8265;
          containers.tdarr =
            let
              port = config.containerPorts.tdarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.tdarr;
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
              toContainer = config.containers.tdarr;
              toPort = config.containerPorts.tdarr.port;
            }
          ];
        };
      };
  };
}
