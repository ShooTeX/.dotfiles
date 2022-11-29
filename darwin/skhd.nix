{ ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # open terminal
      alt - return : ~/Applications/Home\ Manager\ Apps/Kitty.app/Contents/MacOS/kitty --single-instance -d ~
       
      # close focused window
      shift + alt - q : yabai -m window --close
       
      # focus window
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east
       
      # swap window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east
       
      # Resize windows
      lctrl + alt - h : yabai -m window --resize left:-50:0; \
                        yabai -m window --resize right:-50:0
      lctrl + alt - j : yabai -m window --resize bottom:0:50; \
                        yabai -m window --resize top:0:50
      lctrl + alt - k : yabai -m window --resize top:0:-50; \
                        yabai -m window --resize bottom:0:-50
      lctrl + alt - l : yabai -m window --resize right:50:0; \
                        yabai -m window --resize left:50:0

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
       
      # mission control
      cmd - 3 : yabai -m space --toggle mission-control
      f3 : yabai -m space --toggle mission-control

      # restart
      ctrl + alt + cmd - r : launchctl kickstart -k gui/''${UID}/org.nixos.yabai && launchctl kickstart -k gui/''${UID}/org.nixos.skhd
    '';
  };
}
