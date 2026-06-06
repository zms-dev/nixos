/*
  Wayland session bootstrap — XDG portals, SDDM Wayland backend, and Ozone/Electron env vars for native Wayland rendering
  https://wayland.freedesktop.org
*/
{ den, ... }:
{
  den.aspects.gui._.wayland = {
    includes = [
      den.aspects.services._.sddm
    ];

    nixos =
      { pkgs, ... }:
      {
        # System-wide Wayland prerequisites
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
          config.common.default = [ "gtk" ];
        };

        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        services.displayManager.sddm.wayland.enable = true;
      };

    homeManager = {
      home.sessionVariables = {
        # Tell Electron apps to use Wayland natively
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };
    };
  };
}
