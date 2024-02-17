{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.firefox.profiles = {
    default = {
      id = 0;
      userChrome = ''
        @import url('userChrome.css');
      '';
      userContent = ''
        @import url('userContent.css');
      '';
      settings = {
        "devtools.theme" = "dark";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        #"browser.uidensity" = 1;
        #"browser.urlbar.update1" = true;
        "browser.download.dir" = "~/Downloads";
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtab.url" = "about:blank";
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";
        "browser.send_pings" = false;
        "browser.fixup.alternate.enabled" = false;
        "browser.urlbar.update2.engineAliasRefresh" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.pocket.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.gamepad.enabled" = false;
        "beacon.enabled" = false;
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "services.sync.declinedEngines" = "addons,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.prefs" = true;
        "general.smoothScroll" = true;
        "font.name.monospace.x-western" = "Iosevka Nerd Font Mono";
        # "font.name.sans-serif.x-western" = "";
        "font.name.serif.x-western" = "Iosevka Nerd Font";
      };
    };
  };

  home.file = {
    ".mozilla/firefox/default/chrome/userChrome.css".source = pkgs.runCommand "style" {
      buildInputs = [pkgs.sass];
    } ''
      ${pkgs.sass}/bin/scss \
         --sourcemap=none \
         --no-cache \
         --style compressed \
         --default-encoding utf-8 \
          ${./user-chrome.scss} > $out 
    '';

    ".mozilla/firefox/default/chrome/userContent.css".source = pkgs.runCommand "style" {
      buildInputs = [pkgs.sass];
    } ''
      ${pkgs.sass}/bin/scss \
         --sourcemap=none \
         --no-cache \
         --style compressed \
         --default-encoding utf-8 \
          ${./user-content.scss} > $out 
    '';

  };

  #home.sessionVariables.MOZ_USE_XINPUT2 = "1"; # Smooth scrolling
  #programs.firefox.preferences = {
  #  "browser.warnOnQuit" = false;
  #  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  #};
}
