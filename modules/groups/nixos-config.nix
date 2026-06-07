# nixos-config group — system group for NixOS configuration access
{ den, ... }:
{
  den.aspects.groups._.nixos-config = {
    nixos.users.groups.nixos-config.gid = 900;
  };
}
