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
      inputs.hyprland.nixosModules.default
      inputs.nixvim.nixosModules.nixvim
    ];

  #fonts.fontconfig.enable = true;
  #fonts.fontconfig.defaultFonts = {
  #  monospace = [ "Iosevka Nerd Font" ];
  #};
  #fonts.packages = with pkgs; [
  #  (nerdfonts.override { fonts = [ "Iosevka" ]; })
  #];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
