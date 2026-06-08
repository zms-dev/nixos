# isolated — firewall policy aspect for isolated subnet
{ den, ... }:
{
  den.aspects.networking._.zones._.isolated = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.br-isolated
    ];

    nixos =
      { config, ... }:
      let
        isolatedIntf = config.networking.interfaces.br-isolated.name;
      in
      {
        networking.zones.isolated = {
          interface = isolatedIntf;
          forwardRules = [ ];
        };
      };
  };
}
