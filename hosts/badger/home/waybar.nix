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
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "network"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        "hyprland/window" = {
          format = "{}";
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
         background: transparent;
         color: #C8C093;
       }
       .modules-left, .modules-right, .modules-center {
         margin: 4px 8px;
       }
       #workspaces {
         background: #1F1F28;
         border-radius: 10px;
         padding: 0 4px;
       }
       #workspaces button {
         color: #7FB4CA;
         padding: 2px 10px;
         border-radius: 8px;
         border: none;
         background: transparent;
       }
       #workspaces button.active {
         background: #76946A;
         color: #1F1F28;
       }
       #window {
         background: #1F1F28;
         border-radius: 10px;
         padding: 2px 16px;
       }
       #network, #clock, #tray {
         background: #1F1F28;
         border-radius: 10px;
         padding: 2px 12px;
         margin: 0 2px;
       }
       #network { color: #7FB4CA; }
    '';
  };
}
