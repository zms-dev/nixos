# br-isolated — bridge interface configuration for isolated subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-isolated = {
    includes = [
      den.aspects.networking._.bridges._.isolated
      den.aspects.networking._.subnets._.isolated
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.isolated;
      in
      {
        networking.interfaces.br-isolated.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
