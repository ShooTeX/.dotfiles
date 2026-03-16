{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];
      decoration = {
        rounding = 10;
      };
      general = {
        "col.active_border" = "rgba(76946Aff)";
        "col.inactive_border" = "rgba(2D4F67ff)";
        border_size = 2;
      };
      monitor = [ "DP-2,2560x1440@360,0x0,1" ];
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Space, exec, walker"

        "$mod, Q, killactive"
        "$mod SHIFT, E, exec, hyprshutdown"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod SHIFT, H, swapwindow, l"
        "$mod SHIFT, J, swapwindow, d"
        "$mod SHIFT, K, swapwindow, u"
        "$mod SHIFT, L, swapwindow, r"

        "$mod SHIFT, F, fullscreen"
        "$mod, F, fullscreen, 1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      exec-once = [
        "$terminal"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  services.hyprpaper =
    let
      wallpaper = ../../common/wallpapers/kanagawa.jpg;
    in
    {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        wallpaper = {
          monitor = "";
          path = "${wallpaper}";
        };
      };
    };

  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
