/*
  wikimedia — MediaWiki engine for local wikis and documentation
  https://www.mediawiki.org
*/
{ den, ... }:
{
  den.aspects.containers._.wikimedia = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.wikimedia = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 80;
            description = "Wikimedia Web UI port";
          };
        };

        config = {
          networking.hostPorts.wikimedia = 8082;
          containers.wikimedia =
            let
              port = config.containerPorts.wikimedia.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.wikimedia;
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
              toContainer = config.containers.wikimedia;
              toPort = config.containerPorts.wikimedia.port;
            }
          ];
        };
      };
  };
}
