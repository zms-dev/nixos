/*
  buildarr — declarative configuration manager for the *Arr stack
  https://github.com/buildarr/buildarr
*/
{ den, ... }:
{
  den.aspects.containers._.buildarr = {
    includes = [
      den.aspects.networking._.ports
      den.aspects.networking._.interfaces._.br-trusted-egress
    ];

    provides.to-hosts.nixos =
      { config, ... }:
      {
        config = {
          containers.buildarr =
            let
              net = config.networking.subnets.trusted-egress;
              containerIp = net.namedAddresses.buildarr;
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
