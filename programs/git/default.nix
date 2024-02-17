{ config, lib, pkgs, ... }:

{
  programs.git-credential-oauth.enable = true;

  programs.git.enable = true;
  #programs.git.package = pkgs.gitFull;
  programs.git.extraConfig = {
    #credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    color.ui = true;
    core.editor = "nvim";
    credential.helper = ["cache --timeout=7200" "oauth"];
    push.autoSetupRemote = true;
  };
}
