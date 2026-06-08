# br-trusted-egress — bridge interface configuration for trusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-trusted-egress = {
    includes = [
      den.aspects.networking._.bridges._.trusted-egress
      den.aspects.networking._.subnets._.trusted-egress
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.trusted-egress;
      in
      {
        networking.interfaces.br-trust-eg.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
