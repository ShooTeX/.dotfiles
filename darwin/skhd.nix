{ ... }:
{
  services.skhd = {
    enable = false;
    skhdConfig = ''
      # open terminal
      alt - return : wezterm cli spawn --new-window
             
      # close focused window
      shift + alt - q : yabai -m window --close
             
      # focus window
      alt - h : yabai -m window --focus west || yabai -m display --focus west
      alt - j : yabai -m window --focus south || yabai -m display --focus south
      alt - k : yabai -m window --focus north || yabai -m display --focus north
      alt - l : yabai -m window --focus east || yabai -m display --focus east
            
      # swap window
      alt + shift - h : yabai -m window --swap west || $(yabai -m window --display west; yabai -m display --focus west)
      alt + shift - j : yabai -m window --swap south || $(yabai -m window --display south; yabai -m display --focus south)
      alt + shift - k : yabai -m window --swap north || $(yabai -m window --display north; yabai -m display --focus north)
      alt + shift - l : yabai -m window --swap east || $(yabai -m window --display east; yabai -m display --focus east)

      # warp window
      alt + ctrl + shift - h : yabai -m window --warp west || $(yabai -m window --display west; yabai -m display --focus west)
      alt + ctrl + shift - j : yabai -m window --warp south || $(yabai -m window --display south; yabai -m display --focus south)
      alt + ctrl + shift - k : yabai -m window --warp north || $(yabai -m window --display north; yabai -m display --focus north)
      alt + ctrl + shift - l : yabai -m window --warp east || $(yabai -m window --display east; yabai -m display --focus east)
             
      # Resize windows
      lctrl + alt - h : yabai -m window --resize left:-50:0; \
                        yabai -m window --resize right:-50:0
      lctrl + alt - j : yabai -m window --resize bottom:0:50; \
                        yabai -m window --resize top:0:50
      lctrl + alt - k : yabai -m window --resize top:0:-50; \
                        yabai -m window --resize bottom:0:-50
      lctrl + alt - l : yabai -m window --resize right:50:0; \
                        yabai -m window --resize left:50:0

      # create space and follow focus
      shift + alt - n : yabai -m space --create && \
                        index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')" && \
                        yabai -m window --space "''${index}" && \
                        yabai -m space --focus "''${index}"

      # destroy space and focus previous
      shift + alt - d : yabai -m space --destroy && \
                        index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')" && \
                        yabai -m space --focus "''${index}"

      # fast focus space
      shift + alt - x : yabai -m space --focus recent
      shift + alt - 1 : yabai -m space --focus 1
      shift + alt - 2 : yabai -m space --focus 2
      shift + alt - 3 : yabai -m space --focus 3
      shift + alt - 4 : yabai -m space --focus 4
      shift + alt - 5 : yabai -m space --focus 5
      shift + alt - 6 : yabai -m space --focus 6
      shift + alt - 7 : yabai -m space --focus 7
      shift + alt - 8 : yabai -m space --focus 8
            
      # send window to desktop and follow focus
      shift + lctrl + alt - z : yabai -m window --space next; yabai -m space --focus next
      shift + lctrl + alt - 1 : yabai -m window --space  1; yabai -m space --focus 1
      shift + lctrl + alt - 2 : yabai -m window --space  2; yabai -m space --focus 2
      shift + lctrl + alt - 3 : yabai -m window --space  3; yabai -m space --focus 3
      shift + lctrl + alt - 4 : yabai -m window --space  4; yabai -m space --focus 4
      shift + lctrl + alt - 5 : yabai -m window --space  5; yabai -m space --focus 5
      shift + lctrl + alt - 6 : yabai -m window --space  6; yabai -m space --focus 6
      shift + lctrl + alt - 7 : yabai -m window --space  7; yabai -m space --focus 7
      shift + lctrl + alt - 8 : yabai -m window --space  8; yabai -m space --focus 8

      # Equalize size of windows
      shift + alt - e : yabai -m space --balance
             
      # set insertion point for focused container
      ctrl + alt - h : yabai -m window --insert west
      ctrl + alt - j : yabai -m window --insert south
      ctrl + alt - k : yabai -m window --insert north
      ctrl + alt - l : yabai -m window --insert east
             
      # toggle window fullscreen
      alt - f : yabai -m window --toggle zoom-fullscreen
             
      # toggle window native fullscreen
      shift + alt - f : yabai -m window --toggle native-fullscreen
             
      # toggle window split type
      alt - e : yabai -m window --toggle split
             
      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky(+float), topmost, picture-in-picture
      alt - p : yabai -m window --toggle sticky --toggle pip
             
      # mission control
      cmd - 3 : yabai -m space --toggle mission-control
      f3 : yabai -m space --toggle mission-control

      # restart
      ctrl + alt + cmd - r : launchctl kickstart -k gui/''${UID}/org.nixos.yabai && launchctl kickstart -k gui/''${UID}/org.nixos.skhd
    '';
  };
}
