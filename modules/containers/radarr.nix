/*
  radarr — movie collection manager for Usenet and BitTorrent users
  https://radarr.video
*/
{ den, ... }:
{
  den.aspects.containers._.radarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.radarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 7878;
            description = "Radarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.radarr = 7878;
          containers.radarr =
            let
              port = config.containerPorts.radarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.radarr;
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
              toContainer = config.containers.radarr;
              toPort = config.containerPorts.radarr.port;
            }
          ];
        };
      };
  };
}
