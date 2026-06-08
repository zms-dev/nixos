# br-untrusted-egress — bridge interface configuration for untrusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-untrusted-egress = {
    includes = [
      den.aspects.networking._.bridges._.untrusted-egress
      den.aspects.networking._.subnets._.untrusted-egress
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.untrusted-egress;
      in
      {
        networking.interfaces.br-untr-eg.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
