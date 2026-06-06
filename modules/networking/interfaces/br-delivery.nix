{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-delivery = {
    includes = [
      den.aspects.networking._.bridges._.delivery
      den.aspects.networking._.subnets._.delivery
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.delivery;
      in
      {
        networking.interfaces.br-delivery.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
        networking.nat.internalInterfaces = [ "br-delivery" ];
      };
  };
}
