{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-dmz = {
    includes = [
      den.aspects.networking._.bridges._.dmz
      den.aspects.networking._.subnets._.dmz
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.dmz;
      in
      {
        networking.interfaces.br-dmz.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
        networking.nat.internalInterfaces = [ "br-dmz" ];
      };
  };
}
