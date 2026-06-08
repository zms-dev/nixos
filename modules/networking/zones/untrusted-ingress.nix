# untrusted-ingress — firewall policy aspect for untrusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.zones._.untrusted-ingress = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.br-untrusted-ingress
      den.aspects.networking._.interfaces._.bond0
    ];

    nixos =
      { config, ... }:
      let

        untrInIntf = config.networking.interfaces.br-untr-in.name;
        wanIntf = config.networking.nat.externalInterface;
      in
      {
        networking.zones.untrusted-ingress = {
          interface = untrInIntf;
          trustedOutbounds = [ wanIntf ];
          forwardRules = [
            "oifname \"${wanIntf}\" accept"
          ];
        };
      };
  };
}
