/*
  homepage — modern self-hosted services dashboard
  https://gethomepage.dev
*/
{ den, ... }:
{
  den.aspects.containers._.homepage = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.homepage = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "Homepage dashboard port";
          };
        };

        config = {
          networking.hostPorts.homepage = 3002;
          containers.homepage =
            let
              port = config.containerPorts.homepage.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.homepage;
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
              toContainer = config.containers.homepage;
              toPort = config.containerPorts.homepage.port;
            }
          ];
        };
      };
  };
}
