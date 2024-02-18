{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../../boot/default.nix
      ../../../console/default.nix
      ../../../hardware/bluetooth/default.nix
      ../../../hardware/nvidia/default.nix
      ../../../hardware/lg-tv-sscr2/default.nix
      ../../../i18n/default.nix
      ../../../networking/default.nix
      #../../../services/greetd/default.nix
      ../../../services/openssh/default.nix
      ../../../services/xserver/default.nix
      ../../../time/default.nix
      ../../../users/zms/default.nix
      inputs.home-manager.nixosModules.default
      inputs.hyprland.nixosModules.default
      inputs.base16.nixosModule
      inputs.nixvim.nixosModules.nixvim
    ];

  scheme = "${inputs.base16-schemes}/nord.yaml";

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka Nerd Font Mono" ];
  };

  home-manager.sharedModules = [
    inputs.base16.homeManagerModule
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
