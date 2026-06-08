/*
  forgejo — lightweight self-hosted software development platform
  https://forgejo.org
*/
{ den, ... }:
{
  den.aspects.containers._.forgejo = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.forgejo = {
          webPort = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "Forgejo Web UI HTTP port";
          };
          sshPort = lib.mkOption {
            type = lib.types.port;
            default = 22;
            description = "Forgejo SSH port";
          };
        };

        config = {
          networking.hostPorts.forgejo-ssh = 2222;
          networking.hostPorts.forgejo-web = 3001;
          containers.forgejo =
            let
              webPort = config.containerPorts.forgejo.webPort;
              sshPort = config.containerPorts.forgejo.sshPort;
              net = config.networking.subnets.trusted-ingress;
              containerIp = net.namedAddresses.forgejo;
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
                  networking.firewall.allowedTCPPorts = [
                    webPort
                    sshPort
                  ];
                };
            };

          networking.zones.trusted-ingress.forwardRules = [
            {
              toContainer = config.containers.forgejo;
              toPort = config.containerPorts.forgejo.webPort;
            }
            {
              toContainer = config.containers.forgejo;
              toPort = config.containerPorts.forgejo.sshPort;
            }
          ];
        };
      };
  };
}
