{ ... }: {
    services.yabai = {
      enable = true;
      # enableScriptingAddition = true;
      config = {
        focus_follows_mouse          = "autoraise";
        window_border                = "off";
        # window_border_width          = 2;
        # window_border_radius         = 10;
        # active_window_border_color   = "0xff5c7e81";
        # normal_window_border_color   = "0xff505050";
        # insert_window_border_color   = "0xffd75f5f";
        window_shadow                = "off";
        window_animation_duration    = 0;
        active_window_opacity        = 0.8;
        auto_balance                 = "on";
        layout                       = "bsp";
        mouse_modifier               = "shift";
        top_padding                  = 10;
        bottom_padding               = 10;
        left_padding                 = 10;
        right_padding                = 10;
        window_gap                   = 10;
      };

      extraConfig = ''
       yabai -m rule --add app='System Settings' manage=off
       yabai -m space 1 --label code    
       yabai -m space 2 --label www     
       yabai -m space 3 --label chat    
       yabai -m space 4 --label music   
       yabai -m space 5 --label five    
       yabai -m space 6 --label six     
       yabai -m space 7 --label seven   
       yabai -m space 8 --label eight   
       yabai -m rule --add app="Kitty" space=code             
       yabai -m rule --add app="Google Chrome" space=www      
       yabai -m rule --add app="Microsoft Teams" space=chat   
       yabai -m rule --add app="Slack" space=chat             
       yabai -m rule --add app="Signal" space=chat            
       yabai -m rule --add app="WhatsApp" space=chat          
       yabai -m rule --add app="Tidal" space=music
       '';
    };
# };
 }