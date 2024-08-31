{ config, pkgs, lib, nixpkgs, nvim-config, wezterm-config, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    libiconv
    bat
    fd
    xh
    sd
    du-dust
    bottom
    procs
    dogdns
    xcp
    rm-improved
    ripgrep
    hyperfine
    tealdeer
    grex
    unzip
    rustup
    ngrok
    dart
    git-crypt
    gnupg
    jq
    pgcli
    gawk
    git-filter-repo
    wget
    husky
    gitleaks
    plantuml
    ffmpeg

    aerospace

    gnused
    # workaround for nvim-spectre... >:(
    (writeShellScriptBin "gsed" ''exec ${pkgs.gnused}/bin/sed "$@"'')

    #
    qemu
    podman

    # IaC
    terraform

    # kotlin
    kotlin
    http4k
    graalvm-ce
    (gradle.override { java = graalvm-ce; })

    # ocaml
    opam

    # aws
    awscli2

    # node
    bun
    nodejs_20
    nodePackages_latest.yarn
    nodePackages_latest.pnpm
    nodePackages_latest.vercel
    nodePackages_latest.ts-node

    # security
    libfido2
    openssh
    _1password

    # markdown
    glow

    mob

    # go
    go

    #ansible
    ansible
    ansible-lint

    # nix
    nixfmt
    nixos-rebuild
    nixd
    colmena

    sqlite

    httpie

    flyctl

    _1password
  ];

  home.sessionPath = [
    "$HOME/.npm-packages/bin"
    "$HOME/.cargo/bin"
    "$HOME/.pnpm"
    "$HOME/.local/bin"
    "${pkgs.graalvm-ce}/bin"
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    PNPM_HOME = "$HOME/.pnpm";
    GRAALVM_HOME = "${pkgs.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvm-ce}";
    TERMINAL = "wezterm";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv = { enable = true; };
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = false;
    keybindings = { "cmd+t" = "new_tab_with_cwd"; };
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
      symbol_map =
        "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono";
    };
    shellIntegration = { enableZshIntegration = true; };
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

  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };

    extraConfig = {
      user = {
        name = "Erik Simon";
        email = "10850738+ShooTeX@users.noreply.github.com";
      };
      push = { autoSetupRemote = true; };
      pull = { ff = "only"; };
      merge = { ff = "only"; };
      fetch = { prune = true; };
      init = { defaultBranch = "main"; };
    };
  };

  programs.lazygit = { enable = true; };

  programs.gh = { enable = true; };

  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "exa --icons --color=always --group-directories-first";
      sl = "ls";
      lsa = "ls -a";
      l = "ls -l";
      la = "ls -la";

      s = "kitty +kitten ssh";
      icat = "kitten icat";

      ip = "ip --color=auto";

      find = "fd";

      cp = "xcp";

      cd = "z";
    };

    initExtra = ''
      EDITOR=vim
      VISUAL=vim
      eval "$(direnv hook zsh)"
      eval "$(opam env)"
      export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.libiconv}/lib
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = { enable = true; };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[](fg:#FCA17D bg:#86BBD8)"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "[](fg:#86BBD8 bg:#06969A)"
        "$docker_context"
        "[](fg:#06969A bg:#33658A)"
        "$time"
        "[ ](fg:#33658A)"
      ];

      os = {
        disabled = false;
        style = "bg:#9A348E";
        format = "[  $symbol  ]($style)";
        symbols = { Macos = ""; };
      };

      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_status = {
        style = "bg:#FCA17D";
        format = "[$all_status$ahead_behind ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#33658A";
        format = "[ 󰥔 $time ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
    };
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = nvim-config;
    recursive = true;
  };

  xdg.configFile."wezterm/wezterm.lua" = {
    enable = false;
    source = wezterm-config;
  };

  xdg.configFile."wezterm" = {
    source = wezterm-config;
    recursive = true;
  };

  xdg.configFile."aerospace/aerospace.toml".source =
    (pkgs.formats.toml { }).generate "aerospace-config.toml" {
      # Reference: https://github.com/i3/i3/blob/next/etc/config
      start-at-login = true;

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      on-focus-changed = [ "move-mouse window-lazy-center" ];

      mode = {
        main.binding = {
          alt-enter = ''
            exec-and-forget osascript -e '
                  tell application "WezTerm"
                      do script
                      activate
                  end tell'
          '';

          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-f = "fullscreen";

          alt-s = "layout v_accordion"; # "layout stacking" in i3
          alt-w = "layout h_accordion"; # "layout tabbed" in i3
          alt-e =
            "layout tiles horizontal vertical"; # "layout toggle split" in i3

          alt-shift-space = "layout floating tiling"; # 'floating toggle' in i3

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";
          alt-0 = "workspace 10";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
          alt-shift-0 = "move-node-to-workspace 10";

          alt-shift-i = "resize smart -50";
          alt-shift-o = "resize smart +50";

          alt-shift-semicolon = "mode service";
        };
        service.binding = {
          esc = [ "reload-config" "mode main" ];
          r = [ "flatten-workspace-tree" "mode main" ];
          f = [ "layout floating tiling" "mode main" ];
          backspace = [ "close-all-windows-but-current" "mode main" ];
        };
      };

      workspace-to-monitor-force-assignment = {
        "1" = [ "main" ];
        "2" = [ "main" ];
        "3" = [ "main" ];
        "4" = [ "main" ];
        "5" = [ "main" ];
        "6" = [ "secondary" "main" ];
        "7" = [ "secondary" "main" ];
        "8" = [ "secondary" "main" ];
        "9" = [ "secondary" "main" ];
        "10" = [ "secondary" "main" ];
      };

      gaps = {
        inner = {
          horizontal = 10;
          vertical = 10;
        };
        outer = {
          left = 10;
          bottom = 10;
          top = 10;
          right = 10;
        };
      };
    };
}
