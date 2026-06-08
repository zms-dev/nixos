/*
  linkding — simple, fast, and minimal self-hosted bookmark manager
  https://github.com/sissbruecker/linkding
*/
{ den, ... }:
{
  den.aspects.containers._.linkding = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.linkding = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 9090;
            description = "Linkding Web UI port";
          };
        };

        config = {
          networking.hostPorts.linkding = 9090;
          containers.linkding =
            let
              port = config.containerPorts.linkding.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.linkding;
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
              toContainer = config.containers.linkding;
              toPort = config.containerPorts.linkding.port;
            }
          ];
        };
      };
  };
}
