/*
  opencode — VS Code web IDE editor / code-server instance
  https://github.com/coder/code-server
*/
{ den, ... }:
{
  den.aspects.containers._.opencode = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.opencode = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "opencode Web UI port";
          };
        };

        config = {
          networking.hostPorts.opencode = 3003;
          containers.opencode =
            let
              port = config.containerPorts.opencode.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.opencode;
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
              toContainer = config.containers.opencode;
              toPort = config.containerPorts.opencode.port;
            }
          ];
        };
      };
  };
}
