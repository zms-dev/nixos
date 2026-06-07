# time — timezone settings configuration for desktop host
{ ... }:
{
  den.aspects.hosts._.desktop._.time = {
    nixos = {
      time.timeZone = "America/New_York";
    };
  };
}
