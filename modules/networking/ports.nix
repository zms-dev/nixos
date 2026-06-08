# ports — central registry of host ports to prevent collisions
{ den, ... }:
{
  den.aspects.networking._.ports = {
    nixos =
      { config, lib, ... }:
      {
        options.networking.hostPorts = lib.mkOption {
          type = lib.types.attrsOf lib.types.port;
          default = { };
          description = "Central registry of host ports mapped by service name";
        };

        config = {
          assertions =
            let
              allPorts = lib.mapAttrsToList (name: port: { inherit name port; }) config.networking.hostPorts;
              grouped = lib.groupBy (x: toString x.port) allPorts;
              collisions = lib.filterAttrs (port: services: builtins.length services > 1) grouped;
              collisionMessages = lib.mapAttrsToList (
                port: services:
                "Port ${port} is claimed by multiple services: ${lib.concatMapStringsSep ", " (x: x.name) services}"
              ) collisions;
            in
            [
              {
                assertion = collisionMessages == [ ];
                message = "\n" + lib.concatStringsSep "\n" collisionMessages;
              }
            ];
        };
      };
  };
}
