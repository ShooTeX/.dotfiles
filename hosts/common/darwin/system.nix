{
  system = {
    stateVersion = 5;
    defaults = {
      dock = {
        autohide = true;
        minimize-to-application = true;
        show-recents = false;
        static-only = true;
        tilesize = 50;
        # desktop
        wvous-tr-corner = 4;
        # mission control
        wvous-br-corner = 2;
      };
      finder = {
        CreateDesktop = false;
        QuitMenuItem = true;
      };
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "60" = {
              enabled = false;
            };
            "61" = {
              enabled = false;
            };
          };
        };
      };
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;
      };
      spaces = {
        spans-displays = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.pathsToLink = [ "/share/qemu" ];
}
