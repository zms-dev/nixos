{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;
  home.sessionVariables.MOZ_USE_XINPUT2 = "1"; # Smooth scrolling
  #programs.firefox.preferences = {
  #  "browser.warnOnQuit" = false;
  #  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  #};
  programs.firefox.policies = {
    DisableTelemetry = true;
    DefaultDownloadDirectory = "/data/downloads"; # FIXME: should really pass in $DATA
    DisableAppUpdate = true;
    ManualAppUpdateOnly = true;
    DisplayBookmarksToolbar = "newtab";
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    OverrideFirstRunPage = "";
    PasswordManagerEnabled = false;
    EnableTrackingProtection = {
      Value = true;
      Locked = false;
      Cryptomining = true;
      Fingerprinting = true;
    };
    EncryptedMediaExtensions.enabled = false;
    FirefoxHome = {
      Search = false;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
      Locked = false;
    };
    Homepage.StartPage = "previous-session";
    Permissions = {
      Camera.Allow = [ "https://apps.google.com" ];
      Microphone.Allow = [ "https://apps.google.com" ];
      Location.Allow = [];
      Notifications.Allow = [];
      Autoplay.Allow = [];
    };
    PopupBlocking = {
      Allow = [];
      Default = false;
    };
    RequestedLocales = [ "en-US" ];
    ExtensionSettings = {
      "{bb431b02-3350-4b58-b9fd-fb4d5e900fb6}" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/file/3602788/startpage_search_dark_theme-1.0.2.xpi";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "force_installed";
        install_url = "https://github.com/gorhill/uBlock/releases/download/1.52.2/uBlock0_1.52.2.firefox.signed.xpi";
      };
    };
    UserMessaging = {
      WhatsNew = false;
      ExtensionRecommendations = false;
      FeatureRecommendations = false;
      UrlbarInterventions = false;
      SkipOnboarding = true;
      MoreFromMozilla = false;
    };
    WebsiteFilter = {
      Block = [];
    };
  };
}
