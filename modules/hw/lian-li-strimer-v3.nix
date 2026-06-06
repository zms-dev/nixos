# Lian Li Strimer V3 — addressable RGB ARGB cable extension; controlled via OpenRGB
{ den, ... }:
{
  den.aspects.hw._.lian-li-strimer-v3 = {
    includes = [ den.aspects.hw._.rgb ];
  };
}
