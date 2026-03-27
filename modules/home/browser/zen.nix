{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.lab.browser.zen;
in
{
  options.lab.browser.zen = {
    enable = lib.mkEnableOption "Enable zen browser";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

      profiles.default = {
        settings = {
          "zen.workspaces.continue-where-left-off" = false;
          "zen.workspaces.natural-scroll" = true;
          "zen.welcome-screen.seen" = true;
          "zen.urlbar.behavior" = "float";
          "zen.view.window.scheme" = 0;
          "zen.tabs.show-newtab-vertical" = false;
        };
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          onepassword-password-manager
          vimium
          sponsorblock
        ];
        mods = [
          "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
          "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
          "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
          "cb15abdb-0514-4e09-8ce5-722cf1f4a20f" # Hide Extension Name
          "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
          "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
        ];
        containersForce = true;
        containers = {
          Personal = {
            color = "red";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "red";
            icon = "briefcase";
            id = 2;
          };
        };
        spacesForce = true;
        spaces = {
          Main = {
            id = "3fe4c481-0a22-48d4-b945-e22f2af0124e";
            icon = "🔥";
            position = 1000;
            container = 1;
            theme.colors = [
              {
                type = "explicit-lightness";
                red = 0;
                green = 0;
                blue = 0;
                lightness = 0;
              }
            ];
          };
          Work = {
            id = "1356a16e-09c0-4c6f-8edb-9690a2240f60";
            icon = "🧑‍💻";
            position = 2000;
            container = 2;
            theme.colors = [
              {
                red = 120;
                green = 93;
                blue = 56;
                lightness = 100;
              }
            ];
          };
        };
        pinsForce = true;
        pins = {
          "apple music" = {
            id = "f376b41a-c12e-4335-8950-63de03f76ee4";
            container = 1;
            isEssential = true;
            position = 101;
            url = "https://music.apple.com/de/home";
          };
          youtube = {
            id = "7a3abd7c-2e46-4174-a775-c085911fe3c0";
            isEssential = true;
            position = 102;
            url = "https://youtube.com";
          };
          twitch = {
            id = "40001650-c6cf-4651-8d95-c95dce2e70b0";
            isEssential = true;
            position = 103;
            url = "https://twitch.com";
          };
        };
      };
    };
  };
}
