/*
  speedtest-tracker — self-hosted internet speedtest tracker
  https://github.com/alexjustesen/speedtest-tracker
*/
{ den, ... }:
{
  den.aspects.containers._.speedtest-tracker = {
    includes = [ ];
  };
}
