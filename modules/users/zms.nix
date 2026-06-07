# zms — configuration for the primary system user profile
{ den, ... }:
{
  den.aspects.users._.zms = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "zsh")
      den.aspects.cli._.antigravity
      den.aspects.cli._.btop
      den.aspects.cli._.bat
      den.aspects.cli._.claude
      den.aspects.cli._.direnv
      den.aspects.cli._.eza
      den.aspects.cli._.fzf
      den.aspects.cli._.gemini-cli
      den.aspects.cli._.git
      den.aspects.cli._.just
      den.aspects.cli._.lazygit
      den.aspects.cli._.macchina
      den.aspects.cli._.neovim
      den.aspects.cli._.nh
      den.aspects.cli._.oh-my-posh
      den.aspects.cli._.ripgrep
      den.aspects.cli._.television
      den.aspects.cli._.tmux
      den.aspects.cli._.yazi
      den.aspects.cli._.zoxide
      den.aspects.cli._.zsh
      den.aspects.groups._.nixos-config
      den.aspects.dev._.nixd
      den.aspects.dev._.manix
      den.aspects.style._.stylix
    ];

    user.extraGroups = [
      "wheel"
      "nixos-config"
    ];
    user.uid = 1000;

    nixos =
      { config, lib, ... }:
      {
        sops.secrets.zms-password = {
          neededForUsers = true;
        };

        users.users.zms.hashedPasswordFile = config.sops.secrets.zms-password.path;
        users.users.zms.extraGroups = lib.optionals config.hardware.openrazer.enable [ "openrazer" ];

        virtualisation.vmVariant = {
          users.users.zms.password = "nixos";
          users.users.zms.hashedPasswordFile = lib.mkForce null;
          services.getty.autologinUser = "zms";
        };
      };

    homeManager =
      { ... }:
      {
        programs.git = {
          settings = {
            user = {
              name = "zms";
              email = "root@zms.dev";
            };
          };
        };
      };

  };
}
