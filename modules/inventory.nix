# inventory — host and user module assignment inventory
{ den, ... }:
{
  den.hosts.x86_64-linux.desktop = {
    aspect = den.aspects.hosts._.desktop;
    users.zms = {
      aspect = {
        includes = [
          den.aspects.users._.zms
          den.aspects.fonts._.fonts
          den.aspects.gui._.awww
          den.aspects.gui._.niri
          den.aspects.gui._.quickshell
          den.aspects.gui._.mako
          den.aspects.services._.volume-notifications
          den.aspects.apps._.antigravity
          den.aspects.apps._.chromium
          den.aspects.apps._.easyeffects
          den.aspects.apps._.firefox
          den.aspects.apps._.neovide
          den.aspects.apps._.wezterm
          den.aspects.apps._.walker
          den.aspects.apps._.zed
          den.aspects.cli._.cava
          den.aspects.cli._.spotify-player
        ];

        provides.to-hosts.nixos =
          { ... }:
          {
            services.displayManager.autoLogin.enable = true;
            services.displayManager.autoLogin.user = "zms";
          };
      };
    };
  };

  den.hosts.x86_64-linux.server = {
    aspect = den.aspects.hosts._.server;
    users.zms = {
      aspect = den.aspects.users._.zms;
    };
  };
}
