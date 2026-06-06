# platform — host CPU architecture and platform definition for desktop host
{ ... }:
{
  den.aspects.hosts._.desktop._.platform = {
    nixos =
      { lib, ... }:
      {
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      };
  };
}
