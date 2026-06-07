/*
  steelseries-arctis-nova-pro — SteelSeries Arctis Nova Pro wireless headset configuration and integration with HeadsetControl
  https://github.com/SirenOfTiles/HeadsetControl
*/
{ den, ... }:
{
  den.aspects.hw._.steelseries-arctis-nova-pro = {
    includes = [
      den.aspects.hw._.audio
      den.aspects.hw._.headset
    ];

    provides.to-users.homeManager =
      { ... }:
      {
        dconf.settings."com/github/wwmm/easyeffects" = {
          sink-name = "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo";
          use-default-sink = false;
        };
      };
  };
}
