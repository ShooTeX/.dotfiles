{ pkgs, lib, ... }: {
  nix.extraOptions =
    "	auto-optimise-store = true\n	experimental-features = nix-command flakes\n"
    + lib.optionalString (pkgs.system == "aarch64-darwin")
      "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;

  services = {
    nix-daemon.enable = true;
    sketchybar.enable = true;
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    iosevka
    (nerdfonts.override {
      fonts = [ "NerdFontsSymbolsOnly" ];
    })
  ];

  system = {
    defaults = {
      dock = {
        autohide = true;
        minimize-to-application = true;
        show-recents = false;
        static-only = true;
        tilesize = 50;
      };
      finder = {
        CreateDesktop = false;
        QuitMenuItem = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}
