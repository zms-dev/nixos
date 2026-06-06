{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "26.05";
  den.default.nixos.nixpkgs.config.allowUnfree = true;
  den.default.nixos.hardware.enableRedistributableFirmware = true;
  den.default.nixos.documentation.dev.enable = true;
  den.default.nixos.nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  den.default.nixos.nix.settings.auto-optimise-store = true;
  den.default.nixos.environment.variables.FLAKE = "/src/nixos";
  den.default.nixos.environment.variables.NH_FLAKE = "/src/nixos";
  den.default.nixos.nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];
  den.default.nixos.nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  den.default.nixos.home-manager.useGlobalPkgs = true;
  den.default.nixos.home-manager.useUserPackages = true;
  den.default.nixos.home-manager.backupFileExtension = "bak";
  den.default.homeManager.manual.html.enable = true;
  den.default.homeManager.manual.json.enable = true;
  den.default.homeManager.manual.manpages.enable = true;
  den.default.homeManager.home.stateVersion = "26.05";
  den.default.homeManager.systemd.user.startServices = true;
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  den.schema.user.includes = [ den.provides.mutual-provider ];
}
