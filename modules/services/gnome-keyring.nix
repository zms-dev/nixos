/*
  GNOME Keyring — daemon that stores passwords, keys, and certificates
  https://wiki.gnome.org/Projects/GnomeKeyring
*/
{ den, ... }:
{
  den.aspects.services._.gnome-keyring = {
    nixos = {
      services.gnome.gnome-keyring.enable = true;
    };
  };
}
