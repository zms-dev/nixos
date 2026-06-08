/*
  speedtest-tracker — scheduled internet speedtests logger and grapher
  https://github.com/alexjustesen/speedtest-tracker
*/
{ den, ... }:
{
  den.aspects.containers._.speedtest-tracker = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.speedtest-tracker = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 80;
            description = "Speedtest Tracker Web UI port";
          };
        };

        config = {
          networking.hostPorts.speedtest-tracker = 8083;
          containers.speedtest-tracker =
            let
              port = config.containerPorts.speedtest-tracker.port;
              net = config.networking.subnets.untrusted-egress;
              containerIp = net.namedAddresses.speedtest-tracker;
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
              toContainer = config.containers.speedtest-tracker;
              toPort = config.containerPorts.speedtest-tracker.port;
            }
          ];
        };
      };
  };
}
