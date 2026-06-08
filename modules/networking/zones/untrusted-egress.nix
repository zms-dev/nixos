# untrusted-egress — firewall policy aspect for untrusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.zones._.untrusted-egress = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.interfaces._.bond0
    ];

    nixos =
      { config, ... }:
      let

        untrEgIntf = config.networking.interfaces.br-untr-eg.name;
        wanIntf = config.networking.nat.externalInterface;
      in
      {
        networking.zones.untrusted-egress = {
          interface = untrEgIntf;
          trustedOutbounds = [ wanIntf ];
          forwardRules = [
            "oifname \"${wanIntf}\" accept"
          ];
        };
      };
  };
}
