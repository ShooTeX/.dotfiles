{ pkgs, lib, ... }:
let
  monaspace = pkgs.callPackage ./pkgs/fonts/monaspace.nix { };
in
{
  ids.gids.nixbld = 30000;
  nix.optimise.automatic = true;
  nix.extraOptions =
    "	auto-optimise-store = false\n	experimental-features = nix-command flakes\n"
    + lib.optionalString (
      pkgs.system == "aarch64-darwin"
    ) "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;
  system.primaryUser = "eriksimon";

  services = {
    jankyborders = {
      enable = true;
      active_color = "gradient(top_right=0xfffc5c7d,bottom_left=0xff6a82fb)";
      inactive_color = "0x00000000";
      width = 10.0;
    };
    aerospace = {
      enable = true;
      settings = {
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;

        on-focus-changed = [ "move-mouse window-lazy-center" ];

        mode = {
          main.binding = {
            alt-enter = ''
              exec-and-forget osascript -e '
                    tell application "WezTerm"
                        do script
                        activate
                    end tell'
            '';

            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-f = "fullscreen";

            alt-s = "layout v_accordion"; # "layout stacking" in i3
            alt-w = "layout h_accordion"; # "layout tabbed" in i3
            alt-e = "layout tiles horizontal vertical"; # "layout toggle split" in i3

            alt-shift-space = "layout floating tiling"; # 'floating toggle' in i3

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";
            alt-0 = "workspace 10";

            alt-tab = "workspace-back-and-forth";

            alt-shift-1 = [
              "move-node-to-workspace 1"
              "workspace 1"
            ];
            alt-shift-2 = [
              "move-node-to-workspace 2"
              "workspace 2"
            ];
            alt-shift-3 = [
              "move-node-to-workspace 3"
              "workspace 3"
            ];
            alt-shift-4 = [
              "move-node-to-workspace 4"
              "workspace 4"
            ];
            alt-shift-5 = [
              "move-node-to-workspace 5"
              "workspace 5"
            ];
            alt-shift-6 = [
              "move-node-to-workspace 6"
              "workspace 6"
            ];
            alt-shift-7 = [
              "move-node-to-workspace 7"
              "workspace 7"
            ];
            alt-shift-8 = [
              "move-node-to-workspace 8"
              "workspace 8"
            ];
            alt-shift-9 = [
              "move-node-to-workspace 9"
              "workspace 9"
            ];
            alt-shift-0 = [
              "move-node-to-workspace 10"
              "workspace 10"
            ];

            alt-shift-i = "resize smart -50";
            alt-shift-o = "resize smart +50";

            alt-shift-semicolon = "mode service";
          };
          service.binding = {
            esc = [
              "reload-config"
              "mode main"
            ];
            r = [
              "flatten-workspace-tree"
              "mode main"
            ];
            f = [
              "layout floating tiling"
              "mode main"
            ];
            backspace = [
              "close-all-windows-but-current"
              "mode main"
            ];
          };
        };

        workspace-to-monitor-force-assignment = {
          "1" = [ "main" ];
          "2" = [ "main" ];
          "3" = [ "main" ];
          "4" = [ "main" ];
          "5" = [ "main" ];
          "6" = [
            "secondary"
            "main"
          ];
          "7" = [
            "secondary"
            "main"
          ];
          "8" = [
            "secondary"
            "main"
          ];
          "9" = [
            "secondary"
            "main"
          ];
          "10" = [
            "secondary"
            "main"
          ];
        };

        gaps = {
          inner = {
            horizontal = 10;
            vertical = 10;
          };
          outer = {
            left = 10;
            bottom = 10;
            top = 10;
            right = 10;
          };
        };
      };
    };
  };

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.symbols-only
  ];

  users.users.stx.home = "/Users/stx";
  users.users."eriksimon".home = "/Users/eriksimon";

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
