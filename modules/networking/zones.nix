# zone — zone-based declarative firewall and container micro-isolation
{ den, ... }:
{
  den.aspects.networking._.zones = {
    nixos =
      { config, lib, ... }:
      let
        cfg = config.networking.zones;

        # Compiler for forward rules (supports strings or objects)
        compileForwardRule =
          rule:
          if builtins.isString rule then
            rule
          else
            let
              toContainer = rule.toContainer;
              toPort = rule.toPort;
              fromIp = rule.fromIp or null;
              proto = rule.proto or "tcp";
              toIp = builtins.head (lib.splitString "/" toContainer.localAddress);
              saddrPart = if fromIp != null then "ip saddr ${fromIp} " else "";
            in
            "oifname \"${toContainer.hostBridge}\" ${saddrPart}ip daddr ${toIp} ${proto} dport ${toString toPort} accept";

        # Compiler for DNAT rules (supports strings or objects)
        compileDnatRule =
          rule:
          if builtins.isString rule then
            rule
          else
            let
              toContainer = rule.toContainer;
              toPort = rule.toPort;
              hostPort = rule.hostPort;
              proto = rule.proto or "tcp";
              toIp = builtins.head (lib.splitString "/" toContainer.localAddress);
            in
            "${proto} dport ${toString hostPort} dnat to ${toIp}:${toString toPort}";

        # Compiler for input rules (supports strings or objects)
        compileInputRule =
          rule:
          if builtins.isString rule then
            rule
          else
            let
              toPort = rule.toPort;
              fromIp = rule.fromIp or null;
              proto = rule.proto or "tcp";
              saddrPart = if fromIp != null then "ip saddr ${fromIp} " else "";
            in
            "${saddrPart}${proto} dport ${toString toPort} accept";

        # Generate filtering (forward) jumps for active zones
        forwardJumps = lib.concatStringsSep "\n" (
          lib.filter (s: s != "") (
            lib.mapAttrsToList (
              zoneName: zoneDef:
              lib.optionalString (
                zoneDef.forwardRules != [ ] || zoneDef.trustedOutbounds != [ ]
              ) "  iifname \"${zoneDef.interface}\" jump zone_${zoneName}_forward"
            ) cfg
          )
        );

        # Generate NAT (prerouting) jumps for active zones
        preroutingJumps = lib.concatStringsSep "\n" (
          lib.filter (s: s != "") (
            lib.mapAttrsToList (
              zoneName: zoneDef:
              lib.optionalString (
                zoneDef.preroutingRules != [ ]
              ) "  iifname \"${zoneDef.interface}\" jump zone_${zoneName}_prerouting"
            ) cfg
          )
        );

        # Generate input jumps for active zones
        inputJumps = lib.concatStringsSep "\n" (
          lib.filter (s: s != "") (
            lib.mapAttrsToList (
              zoneName: zoneDef:
              lib.optionalString (
                zoneDef.inputRules != [ ]
              ) "  iifname \"${zoneDef.interface}\" jump zone_${zoneName}_input"
            ) cfg
          )
        );

        # Compile the individual zone chains using flat string concatenation
        compileZoneChains = lib.concatStringsSep "\n\n" (
          lib.filter (s: s != "") (
            lib.mapAttrsToList (
              zoneName: zoneDef:
              lib.concatStringsSep "\n\n" (
                lib.filter (s: s != "") [
                  (lib.optionalString (zoneDef.forwardRules != [ ] || zoneDef.trustedOutbounds != [ ]) (
                    "chain zone_${zoneName}_forward {\n"
                    + (lib.optionalString (zoneDef.trustedOutbounds != [ ])
                      "  oifname != { ${
                          lib.concatMapStringsSep ", " (out: "\"${out}\"") zoneDef.trustedOutbounds
                        } } drop\n"
                    )
                    + (lib.concatMapStringsSep "\n" (r: "  " + r) (map compileForwardRule zoneDef.forwardRules))
                    + "\n}"
                  ))
                  (lib.optionalString (zoneDef.preroutingRules != [ ]) (
                    "chain zone_${zoneName}_prerouting {\n"
                    + (lib.concatMapStringsSep "\n" (r: "  " + r) (map compileDnatRule zoneDef.preroutingRules))
                    + "\n}"
                  ))
                  (lib.optionalString (zoneDef.inputRules != [ ]) (
                    "chain zone_${zoneName}_input {\n"
                    + (lib.concatMapStringsSep "\n" (r: "  " + r) (map compileInputRule zoneDef.inputRules))
                    + "\n}"
                  ))
                ]
              )
            ) cfg
          )
        );
      in
      {
        options.networking.zones = lib.mkOption {
          default = { };
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                interface = lib.mkOption {
                  type = lib.types.str;
                  description = "The network interface associated with this zone";
                };
                trustedOutbounds = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [ ];
                  description = "List of outbound interfaces this zone is trusted to establish connections to";
                };
                forwardRules = lib.mkOption {
                  type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                  default = [ ];
                  description = "Raw filtering rules (strings) or structured objects for this zone chain";
                };
                preroutingRules = lib.mkOption {
                  type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                  default = [ ];
                  description = "Raw DNAT/prerouting rules (strings) or structured objects for this zone chain";
                };
                inputRules = lib.mkOption {
                  type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                  default = [ ];
                  description = "Raw input filtering rules (strings) or structured objects for this zone chain";
                };
              };
            }
          );
        };

        config = lib.mkIf (cfg != { }) {
          networking.nftables = {
            enable = true;
            tables.firewall = {
              family = "ip";
              content = ''
                chain input {
                  type filter hook input priority filter; policy drop;
                  ct state established,related accept
                  ct state invalid drop
                  iifname "lo" accept

                  # Dynamically injected input jumps
                ${inputJumps}
                }

                chain forward {
                  type filter hook forward priority filter; policy drop;
                  ct state established,related accept
                  ct state invalid drop

                  # Dynamically injected forward jumps
                ${forwardJumps}
                }

                chain prerouting {
                  type nat hook prerouting priority dstnat; policy accept;

                  # Dynamically injected prerouting jumps
                ${preroutingJumps}
                }

                chain postrouting {
                  type nat hook postrouting priority srcnat; policy accept;
                  oifname "${config.networking.nat.externalInterface}" masquerade
                }

                # Dynamically generated zone chains
                ${compileZoneChains}
              '';
            };
          };
        };
      };
  };
}
