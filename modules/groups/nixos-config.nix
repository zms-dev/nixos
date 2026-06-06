{ den, ... }:
{
  den.aspects.groups._.nixos-config = {
    nixos.users.groups.nixos-config.gid = 900;
  };
}
