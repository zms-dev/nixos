/*
  home-assistant — open-source home automation platform
  https://www.home-assistant.io
*/
{ den, ... }:
{
  den.aspects.containers._.home-assistant = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.home-assistant = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8123;
            description = "Home Assistant Web UI port";
          };
        };

        config = {
          networking.hostPorts.home-assistant = 8123;
          containers.home-assistant =
            let
              port = config.containerPorts.home-assistant.port;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.home-assistant;
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
              toContainer = config.containers.home-assistant;
              toPort = config.containerPorts.home-assistant.port;
            }
          ];
        };
      };
  };
}
