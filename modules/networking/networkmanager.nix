{ den, ... }:
{
  den.aspects.networking._.networkmanager = {
    nixos =
      { lib, ... }:
      {
        networking = {
          networkmanager.dns = "systemd-resolved";
          networkmanager.enable = true;
          networkmanager.unmanaged = [
            "interface-name:ve-*"
            "interface-name:br-*"
          ];
        };
      };
  };
}
