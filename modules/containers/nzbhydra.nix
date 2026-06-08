/*
  nzbhydra — meta search engine for Usenet indexers
  https://github.com/theotherp/nzbhydra2
*/
{ den, ... }:
{
  den.aspects.containers._.nzbhydra = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.nzbhydra = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 5076;
            description = "NZBHydra Web UI port";
          };
        };

        config = {
          networking.hostPorts.nzbhydra = 5076;
          containers.nzbhydra =
            let
              port = config.containerPorts.nzbhydra.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.nzbhydra;
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
              toContainer = config.containers.nzbhydra;
              toPort = config.containerPorts.nzbhydra.port;
            }
          ];
        };
      };
  };
}
