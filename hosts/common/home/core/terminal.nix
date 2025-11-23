{ wezterm-config, ... }:

{
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    # installVimSyntax = true;
    # systemd = {
    #   enable = true;
    # };

    package = null; # managed by homebrew

    settings = {
      theme = "Kanagawa Dragon";

      font-family = "Terminus (TTF)";
      font-size = 18;
      # font-thicken = true;
      # font-thicken-strength = 0;

      macos-titlebar-style = "hidden";

      quit-after-last-window-closed = true;
      macos-option-as-alt = true;

      cursor-style = "block";
      shell-integration-features = "no-cursor";
    };
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua" = {
      enable = false;
      source = wezterm-config;
    };
    "wezterm" = {
      source = wezterm-config;
      recursive = true;
    };
  };

  programs.kitty = {
    enable = false;
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    font = {
      name = "Iosevka";
      size = 16;
    };
    settings = {
      shell_integration = true;
      macos_option_as_alt = true;
      macos_quit_when_last_window_closed = true;
      hide_window_decorations = "titlebar-only";
      disable_ligatures = "cursor";
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    extraConfig = ''
      # vim:ft=kitty

      ## name: Kanagawa
      ## license: MIT
      ## author: Tommaso Laurenzi
      ## upstream: https://github.com/rebelot/kanagawa.nvim/


      background #1F1F28
      foreground #DCD7BA
      selection_background #2D4F67
      selection_foreground #C8C093
      url_color #72A7BC
      cursor #C8C093

      # Tabs
      active_tab_background #1F1F28
      active_tab_foreground #C8C093
      inactive_tab_background  #1F1F28
      inactive_tab_foreground #727169
      #tab_bar_background #15161E

      # normal
      color0 #16161D
      color1 #C34043
      color2 #76946A
      color3 #C0A36E
      color4 #7E9CD8
      color5 #957FB8
      color6 #6A9589
      color7 #C8C093

      # bright
      color8  #727169
      color9  #E82424
      color10 #98BB6C
      color11 #E6C384
      color12 #7FB4CA
      color13 #938AA9
      color14 #7AA89F
      color15 #DCD7BA


      # extended colors
      color16 #FFA066
      color17 #FF5D62
    '';
  };
}
