/*
  nzxt-n9-x870e — NZXT N9 X870E motherboard RGB controller configuration via OpenRGB
  https://gitlab.com/CalcProgrammer1/OpenRGB
*/
{ den, ... }:
{
  den.aspects.hw._.nzxt-n9-x870e = {
    includes = [ den.aspects.hw._.rgb ];
    nixos =
      { ... }:
      {
        services.hardware.openrgb.motherboard = "amd";
      };
  };
}
