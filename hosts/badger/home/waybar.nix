{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        "network" = {
          format = "";
          format-ethernet = "";
          format-disconnected = "󰤭 disconnected";
        };
        "tray" = {
          spacing = 8;
        };
      };
    };

    style = ''
      window#waybar {
         color: #c4b28a;
         background: transparent;
         font-family: "Iosevka Comfy Fixed";
         font-weight: bold;
       }
       .modules-left, .modules-right, .modules-center {
         margin: 10px 20px 0px;
       }
       #workspaces {
         background: #181616;
       }
       #workspaces button {
         color: #c4b28a;
         background: transparent;
         border-radius: 0;
       }
       #workspaces button.active {
         background: #8ba4b0;
         color: #181616;
       }
       #network, #clock, #tray {
         background: #181616;
         padding: 2px 12px;
         margin: 0 2px;
       }
       #network { color: #8ba4b0; }
    '';
  };
}
