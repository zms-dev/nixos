# br-untrusted-ingress — bridge interface configuration for untrusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-untrusted-ingress = {
    includes = [
      den.aspects.networking._.bridges._.untrusted-ingress
      den.aspects.networking._.subnets._.untrusted-ingress
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.untrusted-ingress;
      in
      {
        networking.interfaces.br-untr-in.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
