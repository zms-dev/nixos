# br-trusted-ingress — bridge interface configuration for trusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-trusted-ingress = {
    includes = [
      den.aspects.networking._.bridges._.trusted-ingress
      den.aspects.networking._.subnets._.trusted-ingress
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.trusted-ingress;
      in
      {
        networking.interfaces.br-trust-in.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
