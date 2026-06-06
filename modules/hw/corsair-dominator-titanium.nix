# Corsair Dominator Titanium — DDR5 RGB RAM; sets white Direct mode via OpenRGB at boot
{ den, ... }:
{
  den.aspects.hw._.corsair-dominator-titanium = {
    includes = [
      den.aspects.hw._.rgb
      den.aspects.hw._.mem
    ];
    nixos =
      { pkgs, lib, ... }:
      {
        boot.kernelModules = [ "i2c-dev" ];

        systemd.services.corsair-dominator-rgb = {
          wantedBy = [ "multi-user.target" ];
          after = [ "openrgb.service" ];
          requires = [ "openrgb.service" ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = pkgs.writeShellScript "corsair-dominator-rgb" ''
              ${lib.getExe pkgs.openrgb} \
                --device "Corsair Dominator Platinum" \
                --mode Direct \
                --color ffffff
            '';
          };
        };
      };
  };
}
