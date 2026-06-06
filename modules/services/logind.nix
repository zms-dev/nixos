/*
  logind — systemd login manager; configures seat management, power key handling, and idle inhibition
  https://www.freedesktop.org/software/systemd/man/logind.conf.html
*/
{ ... }:
{
  den.aspects.services._.logind = {
    nixos = {
      services.logind.settings.Login.HandlePowerKey = "poweroff";
    };
  };
}
