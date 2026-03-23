{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];
      decoration = {
        shadow = {
          enabled = false;
        };
      };
      general = {
        "col.active_border" = "rgba(A292A3FF)";
        "col.inactive_border" = "rgba(00000000)";
        border_size = 2;
      };
      input = {
        accel_profile = "flat";
        sensitivity = 0;
      };
      monitor = [
        "DP-1,2560x1440@60,-2560x0,1"
        "DP-2,2560x1440@360,0x0,1,bitdepth,10,cm,auto"
      ];
      workspace = [
        "1,monitor:DP-2,default:true"
        "r[2-5],monitor:DP-2"
        "6,monitor:DP-1,default:true"
        "r[7-0],monitor:DP-1"
      ];
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

        "$mod CTRL, H, movewindow, l"
        "$mod CTRL, J, movewindow, d"
        "$mod CTRL, K, movewindow, u"
        "$mod CTRL, L, movewindow, r"

        "$mod SHIFT, F, fullscreen"
        "$mod, F, fullscreen, 1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 0"
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
      wallpaper = ../../../wallpapers/kanagawa.jpg;
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
