# subnets — option definitions for declarative L3 subnets
{ den, ... }:
{
  den.aspects.networking._.subnets = {
    nixos =
      { lib, ... }:
      {
        options.networking.subnets = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                subnet = lib.mkOption {
                  type = lib.types.str;
                  description = "The subnet network IP address (e.g. 10.100.30.0)";
                };
                prefixLength = lib.mkOption {
                  type = lib.types.int;
                  default = 24;
                  description = "The prefix length of the subnet";
                };
                gateway = lib.mkOption {
                  type = lib.types.str;
                  description = "The gateway IP address on this subnet";
                };
                namedAddresses = lib.mkOption {
                  type = lib.types.attrsOf lib.types.str;
                  default = { };
                  description = "Static IP mappings for named hosts on this subnet";
                };
              };
            }
          );
          default = { };
          description = "Declarative L3 subnets";
        };
      };
  };
}
