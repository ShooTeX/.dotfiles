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
       
      # increase region size
      shift + alt - a : yabai -m window --resize left:-100:0
      shift + alt - w : yabai -m window --resize top:0:-100
      shift + alt - d : yabai -m window --resize right:100:0
      shift + alt - s : yabai -m window --resize bottom:0:100
       
      # decrease region size
      shift + cmd - a : yabai -m window --resize left:100:0
      shift + cmd - w : yabai -m window --resize top:0:100
      shift + cmd - d : yabai -m window --resize right:-100:0
      shift + cmd - s : yabai -m window --resize bottom:0:-100
       
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
      ctrl + alt + cmd - r : launchctl kickstart -k gui/$\{UID}/org.nixos.yabai && launchctl kickstart -k gui/$\{UID}/org.nixos.skhd
    '';
  };
}
