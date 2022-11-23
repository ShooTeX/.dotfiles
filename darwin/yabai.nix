{ ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
      # load scripting addition
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # bar configuration
      # yabai -m config external_bar all:0:39
      # yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"

      yabai -m config                           \
        window_border on                        \
        window_border_width 2                   \
        active_window_border_color 0xFF40FF00   \
        normal_window_border_color 0x00FFFFFF   \
        insert_feedback_color 0xffd75f5f        \
        window_shadow off                       \
        layout bsp                              \
        auto_balance off                        \
        window_topmost on                       \

        top_padding    0 \
        bottom_padding 0 \
        left_padding   0 \
        right_padding  0 \
        window_gap     0 \

        -m rule --add app="^System Preferences$" manage=off \

        -m space 1 --label code   \
        -m space 2 --label www    \
        -m space 3 --label chat   \
        -m space 4 --label music  \
        -m space 5 --label five   \
        -m space 6 --label six    \
        -m space 7 --label seven  \
        -m space 8 --label eight  \

        -m rule --add app="Kitty" space=code            \
        -m rule --add app="Google Chrome" space=www     \
        -m rule --add app="Microsoft Teams" space=chat  \
        -m rule --add app="Slack" space=chat            \
        -m rule --add app="Signal" space=chat           \
        -m rule --add app="WhatsApp" space=chat         \
        -m rule --add app="Tidal" space=music

      echo "yabai configuration loaded.."
      '';
  };
}
