/*
  SDDM — Qt-based display manager for X11 and Wayland; used as the login manager with Wayland backend
  https://github.com/sddm/sddm
*/
{ den, ... }:
{
  den.aspects.services._.sddm = {
    nixos = {
      services.displayManager.sddm.enable = true;
    };
  };
}
