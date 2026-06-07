# networking — network configuration and hostname settings for desktop host
{ den, ... }:
{
  den.aspects.hosts._.desktop._.networking = {
    includes = [
      den.aspects.services._.resolved
      den.aspects.networking._.networkmanager
    ];

    nixos = {
      networking.hostName = "desktop";
    };
  };
}
