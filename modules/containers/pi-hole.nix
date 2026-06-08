/*
  pi-hole — network-wide ad blocking and local DNS resolver
  https://pi-hole.net
*/
{ den, ... }:
{
  den.aspects.containers._.pi-hole = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-isolated
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.pi-hole = {
          dnsPort = lib.mkOption {
            type = lib.types.port;
            default = 53;
            description = "Pi-hole DNS port";
          };
          webPort = lib.mkOption {
            type = lib.types.port;
            default = 80;
            description = "Pi-hole Web UI port";
          };
        };

        config = {
          networking.hostPorts.pi-hole-dns = 5353;
          networking.hostPorts.pi-hole-web = 8080;
          containers.pi-hole =
            let
              dnsPort = config.containerPorts.pi-hole.dnsPort;
              webPort = config.containerPorts.pi-hole.webPort;
              net = config.networking.subnets.isolated;
              containerIp = net.namedAddresses.pi-hole;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-isolated.name;
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
                  networking.firewall.allowedTCPPorts = [
                    dnsPort
                    webPort
                  ];
                  networking.firewall.allowedUDPPorts = [ dnsPort ];
                };
            };

          networking.zones.trusted-ingress.forwardRules = [
            {
              toContainer = config.containers.pi-hole;
              toPort = config.containerPorts.pi-hole.dnsPort;
            }
            {
              toContainer = config.containers.pi-hole;
              toPort = config.containerPorts.pi-hole.dnsPort;
              proto = "udp";
            }
            {
              toContainer = config.containers.pi-hole;
              toPort = config.containerPorts.pi-hole.webPort;
            }
          ];
        };
      };
  };
}
