/*
  UPower — D-Bus power management abstraction layer; exposes battery state and charge thresholds to userspace
  https://gitlab.freedesktop.org/upower/upower
*/
{ ... }:
{
  den.aspects.services._.upower = {
    nixos = {
      services.upower = {
        enable = true;
        usePercentageForPolicy = true;
        percentageCritical = 5;
        percentageLow = 20;
      };
    };
  };
}
