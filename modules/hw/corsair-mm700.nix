# Corsair MM700 — RGB extended gaming mousepad; sets per-zone white Direct mode via OpenRGB
{ den, ... }:
{
  den.aspects.hw._.corsair-mm700 = {
    includes = [ den.aspects.hw._.rgb ];
    nixos =
      { pkgs, lib, ... }:
      {
        systemd.services.corsair-mm700-rgb = {
          wantedBy = [ "multi-user.target" ];
          after = [ "openrgb.service" ];
          requires = [ "openrgb.service" ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = pkgs.writeShellScript "corsair-mm700-rgb" ''
              ${lib.getExe pkgs.openrgb} \
                --device "Corsair MM700" \
                --mode Direct \
                --zone 0 \
                --color ffffff,ffffff,00ff00
            '';
          };
        };
      };
  };
}
