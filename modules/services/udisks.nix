/*
  udisks2 — disk management service for querying, mounting, and unmounting storage devices
  https://www.freedesktop.org/wiki/Software/udisks/
*/
{ den, ... }:
{
  den.aspects.services._.udisks = {
    nixos = {
      services.udisks2.enable = true;
    };
  };
}
