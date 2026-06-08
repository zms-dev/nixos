# trusted-egress — firewall policy aspect for trusted-egress subnet
{ den, ... }:
{
  den.aspects.networking._.zones._.trusted-egress = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.interfaces._.br-untrusted-ingress
      den.aspects.networking._.interfaces._.bond0
    ];

    nixos =
      { config, ... }:
      let
        trustEgIntf = config.networking.interfaces.br-trust-eg.name;
        untrInIntf = config.networking.interfaces.br-untr-in.name;
        wanIntf = config.networking.nat.externalInterface;
      in
      {
        networking.zones.trusted-egress = {
          interface = trustEgIntf;
          trustedOutbounds = [
            wanIntf
            untrInIntf
          ];
          forwardRules = [
            "oifname \"${wanIntf}\" accept"
          ];
        };
      };
  };
}
