# time — timezone settings configuration for server host
{ ... }:
{
  den.aspects.hosts._.server._.time = {
    nixos = {
      time.timeZone = "America/New_York";
    };
  };
}
