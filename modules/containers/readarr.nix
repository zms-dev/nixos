/*
  readarr — ebook and audiobook collection manager for Usenet and BitTorrent users
  https://readarr.com
*/
{ den, ... }:
{
  den.aspects.containers._.readarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.zones._.trusted-ingress
    ];

    provides.to-hosts.nixos =
      { config, lib, ... }:
      {
        options.containerPorts.readarr = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 8787;
            description = "Readarr Web UI port";
          };
        };

        config = {
          networking.hostPorts.readarr = 8787;
          containers.readarr =
            let
              port = config.containerPorts.readarr.port;
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.readarr;
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
              toContainer = config.containers.readarr;
              toPort = config.containerPorts.readarr.port;
            }
          ];
        };
      };
  };
}
