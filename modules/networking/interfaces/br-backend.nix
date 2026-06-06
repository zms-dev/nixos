{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-backend = {
    includes = [
      den.aspects.networking._.bridges._.backend
      den.aspects.networking._.subnets._.backend
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.backend;
      in
      {
        networking.interfaces.br-backend.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
      };
  };
}
