{ config, lib, pkgs, inputs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "zms";
      };
      default_session = initial_session;
    };
  };
}
