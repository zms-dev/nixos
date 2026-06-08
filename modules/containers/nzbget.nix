/*
  nzbget — binary newsgrabber for Usenet downloads
  https://nzbget.net
*/
{ den, ... }:
{
  den.aspects.containers._.nzbget = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.nzbget = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 6789;
            description = "NZBGet Web UI port";
          };
        };

        config = {
          networking.hostPorts.nzbget = 6789;
          containers.nzbget =
            let
              port = config.containerPorts.nzbget.port;
              net = config.networking.subnets.untrusted-egress;
              containerIp = net.namedAddresses.nzbget;
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
              toContainer = config.containers.nzbget;
              toPort = config.containerPorts.nzbget.port;
            }
          ];
        };
      };
  };
}
