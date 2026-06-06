/*
  niri — scrollable-tiling Wayland compositor; columns scroll infinitely on a horizontal axis, built on Smithay
  https://github.com/YaLTeR/niri
*/
{ den, inputs, ... }:
{
  # This tells flake-file to fetch niri's flake, making it available
  # to the configuration without touching the root flake.nix
  flake-file.inputs = {
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.gui._.niri = {
    includes = [
      den.aspects.hw._.graphics
      den.aspects.gui._.wayland
      den.aspects.gui._.awww
      den.aspects.gui._.niri._.binds
      den.aspects.gui._.niri._.layer-rules
      den.aspects.gui._.niri._.layout
      den.aspects.gui._.niri._.window-rules
      den.aspects.gui._.niri._.workspaces
    ];

    nix.extra-substituters = [ "https://niri.cachix.org" ];
    nix.extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];

    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.niri-flake.nixosModules.niri ];
        nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
        services.displayManager.defaultSession = "niri";
      };

    homeManager =
      { ... }:
      {
        programs.niri.settings = {
          # environment = {
          #   NIXOS_OZONE_WL = "1";
          # };
          gestures.hot-corners.enable = false;

          prefer-no-csd = true;

          spawn-at-startup = [
            {
              command = [
                "systemctl"
                "--user"
                "import-environment"
                "WAYLAND_DISPLAY"
                "XDG_CURRENT_DESKTOP"
                "PATH"
              ];
            }
            {
              command = [
                "dbus-update-activation-environment"
                "--systemd"
                "WAYLAND_DISPLAY"
                "XDG_CURRENT_DESKTOP"
                "PATH"
              ];
            }
          ];
        };
      };
  };
}
