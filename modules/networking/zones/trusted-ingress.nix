# trusted-ingress — firewall policy aspect for trusted-ingress subnet
{ den, ... }:
{
  den.aspects.networking._.zones._.trusted-ingress = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.br-trusted-ingress
      den.aspects.networking._.interfaces._.br-untrusted-egress
      den.aspects.networking._.interfaces._.br-trusted-egress
      den.aspects.networking._.interfaces._.br-isolated
      den.aspects.networking._.interfaces._.bond0
    ];

    nixos =
      { config, ... }:
      let
        trustInIntf = config.networking.interfaces.br-trust-in.name;
        untrEgIntf = config.networking.interfaces.br-untr-eg.name;
        trustEgIntf = config.networking.interfaces.br-trust-eg.name;
        isolatedIntf = config.networking.interfaces.br-isolated.name;
        wanIntf = config.networking.nat.externalInterface;
      in
      {
        networking.zones.trusted-ingress = {
          interface = trustInIntf;
          trustedOutbounds = [
            wanIntf
            untrEgIntf
            trustEgIntf
            isolatedIntf
            trustInIntf
          ];
          forwardRules = [
            "oifname \"${wanIntf}\" accept"
          ];
        };
      };
  };
}
