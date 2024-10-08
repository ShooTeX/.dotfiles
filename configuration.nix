{ pkgs, lib, ... }:
let monaspace = pkgs.callPackage ./pkgs/fonts/monaspace.nix { };
in {
  nix.optimise.automatic = true;
  nix.extraOptions =
    "	auto-optimise-store = true\n	experimental-features = nix-command flakes\n"
    + lib.optionalString (pkgs.system == "aarch64-darwin")
    "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;

  services = {
    nix-daemon.enable = true;
    jankyborders = {
      enable = true;
      active_color = "gradient(top_right=0xfffc5c7d,bottom_left=0xff6a82fb)";
      inactive_color = "0x00000000";
      width = 10.;
    };
  };

  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  users.users.stx.home = "/Users/stx";
  users.users."eriksimon".home = "/Users/eriksimon";

  system = {
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

  security.pam.enableSudoTouchIdAuth = true;

  environment.pathsToLink = [ "/share/qemu" ];
}
