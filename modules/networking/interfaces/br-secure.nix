# br-secure — bridge interface configuration for secure subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-secure = {
    includes = [
      den.aspects.networking._.bridges._.secure
      den.aspects.networking._.subnets._.secure
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.secure;
      in
      {
        networking.interfaces.br-secure.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
