{ pkgs, ... }:
{
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
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.natural-scroll" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.animate-sidebar" = false;
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
        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
        "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Zen Back Forward
      ];
      containersForce = true;
      spacesForce = true;
      spaces = {
        Main = {
          id = "b23180fc-ac16-4ab6-afa1-1f878327b3b8";
          position = 1000;
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
      };
      pinsForce = true;
      pins = {
        "apple music" = {
          id = "8653a1ab-fc32-47f4-b95e-1decdb7b6104";
          isEssential = true;
          position = 101;
          url = "https://music.apple.com";
        };
        youtube = {
          id = "796ba193-8b92-47f2-b388-c0d0d2591f8a";
          isEssential = true;
          position = 102;
          url = "https://youtube.com";
        };
        twitch = {
          id = "0383d5f3-6e09-4816-b9ed-e931380021cc";
          isEssential = true;
          position = 103;
          url = "https://twitch.com";
        };
      };
    };
  };
}
