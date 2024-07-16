{ pkgs, lib, ... }:
let monaspace = pkgs.callPackage ./pkgs/fonts/monaspace.nix { };
in {
  nix.extraOptions =
    "	auto-optimise-store = true\n	experimental-features = nix-command flakes\n"
    + lib.optionalString (pkgs.system == "aarch64-darwin")
    "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;

  services = {
    nix-daemon.enable = true;
    # sketchybar.enable = true;
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
      NSGlobalDomain.AppleKeyboardUIMode = 3;
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  environment.pathsToLink = [ "/share/qemu" ];
}
