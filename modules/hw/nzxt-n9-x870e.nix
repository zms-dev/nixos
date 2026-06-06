# NZXT N9 X870E — AMD AM5 ATX motherboard; configures OpenRGB AMD chipset zone
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
