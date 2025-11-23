{
  programs.zellij.settings.keybinds = {
    shared_among = {
      _args = [
        "normal"
        "locked"
      ];
      _children = [
        {
          unbind = {
            _args = [
              "Alt left"
              "Alt right"
              "Alt up"
              "Alt down"
              "Alt ["
              "Alt ]"
              "Alt +"
              "Alt -"
              "Alt ="
              "Alt o"
              "Alt i"
              "Alt n"
              "Alt f"
              "Alt h"
              "Alt j"
              "Alt k"
              "Alt l"
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt left" ];
            _children = [
              { MoveFocusOrTab._args = [ "left" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt down" ];
            _children = [
              { MoveFocus._args = [ "down" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt up" ];
            _children = [
              { MoveFocus._args = [ "up" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt right" ];
            _children = [
              { MoveFocusOrTab._args = [ "right" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt +" ];
            _children = [
              { Resize._args = [ "Increase" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt -" ];
            _children = [
              { Resize._args = [ "Decrease" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt =" ];
            _children = [
              { Resize._args = [ "Increase" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt [" ];
            _children = [
              { PreviousSwapLayout = { }; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt ]" ];
            _children = [
              { NextSwapLayout = { }; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt f" ];
            _children = [
              { ToggleFloatingPanes = { }; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt h" ];
            _children = [
              { MoveFocusOrTab._args = [ "left" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt j" ];
            _children = [
              { MoveFocus._args = [ "down" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt k" ];
            _children = [
              { MoveFocus._args = [ "up" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt l" ];
            _children = [
              { MoveFocusOrTab._args = [ "right" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt n" ];
            _children = [
              { NewPane = { }; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt o" ];
            _children = [
              { MoveTab._args = [ "right" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt i" ];
            _children = [
              { MoveTab._args = [ "left" ]; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt [" ];
            _children = [
              { PreviousSwapLayout = { }; }
            ];
          };
        }
        {
          bind = {
            _args = [ "Ctrl Alt ]" ];
            _children = [
              { NextSwapLayout = { }; }
            ];
          };
        }
      ];
    };
  };
}
