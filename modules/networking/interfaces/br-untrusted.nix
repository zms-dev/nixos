# br-untrusted — bridge interface configuration for untrusted subnet
{ den, ... }:
{
  den.aspects.networking._.interfaces._.br-untrusted = {
    includes = [
      den.aspects.networking._.bridges._.untrusted
      den.aspects.networking._.subnets._.untrusted
    ];

    nixos =
      { config, ... }:
      let
        net = config.networking.subnets.untrusted;
      in
      {
        networking.interfaces.br-untrusted.ipv4.addresses = [
          {
            address = net.gateway;
            prefixLength = net.prefixLength;
          }
        ];
        networking.nat.internalInterfaces = [ "br-untrusted" ];
      };
  };
}
