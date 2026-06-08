/*
  recyclarr — CLI tool to sync TRaSH Guides configs to Radarr and Sonarr
  https://recyclarr.dev
*/
{ den, ... }:
{
  den.aspects.containers._.recyclarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
    ];

    provides.to-hosts.nixos =
      { config, ... }:
      {
        config = {
          containers.recyclarr =
            let
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.recyclarr;
              extraHosts = config.networking.subnetExtraHosts;
            in
            {
              autoStart = true;
              privateNetwork = true;
              hostBridge = config.networking.interfaces.br-trust-eg.name;
              localAddress = "${containerIp}/${toString net.prefixLength}";
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
                };
            };
        };
      };
  };
}
