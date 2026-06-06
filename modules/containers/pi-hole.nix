/*
  pi-hole — network-wide ad blocking via DNS sinkhole
  https://github.com/pi-hole/pi-hole
*/
{ den, ... }:
{
  den.aspects.containers._.pi-hole = {
    includes = [ ];
  };
}
