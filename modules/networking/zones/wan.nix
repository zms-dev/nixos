# wan — firewall policy aspect for external WAN network interface
{ den, ... }:
{
  den.aspects.networking._.zones._.wan = {
    includes = [
      den.aspects.networking._.zones
      den.aspects.networking._.interfaces._.bond0
      den.aspects.networking._.interfaces._.br-untrusted-ingress
      den.aspects.networking._.interfaces._.br-trusted-ingress
    ];

    nixos =
      { config, lib, ... }:
      let
        wanIntf = config.networking.nat.externalInterface;
        untrInIntf = config.networking.interfaces.br-untr-in.name;
        trustInIntf = config.networking.interfaces.br-trust-in.name;
      in
      {
        networking.zones.wan = {
          interface = wanIntf;
          trustedOutbounds = [
            untrInIntf
            trustInIntf
          ];
          forwardRules = [ ];
          preroutingRules = [ ];
          inputRules = lib.mkIf config.services.openssh.enable (
            map (port: { toPort = port; }) config.services.openssh.ports
          );
        };
      };
  };
}
