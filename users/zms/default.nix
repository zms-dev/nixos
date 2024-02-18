{ config, lib, pkgs, inputs, ... }:

{
  users.users.zms = {
    isNormalUser = true;
    description = "zms";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  home-manager = {
    useGlobalPkgs = true;
    verbose = true;
    extraSpecialArgs = {inherit inputs;};
    users.zms = import ./home.nix;
  };

  programs.zsh.enable = true;
}
