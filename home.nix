{
  pkgs,
  config,
  nvim-config,
  wezterm-config,
  ...
}:

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
    (gradle.override { java = graalvm-ce; })
    _1password-cli
    aerospace
    agenix-cli
    awscli2
    bat
    bottom
    cmake
    dogdns
    du-dust
    fd
    ffmpeg
    gawk
    git-crypt
    github-mcp-server
    gitleaks
    glow
    gnupg
    go
    graalvm-ce
    grex
    http4k
    httpie
    husky
    hyperfine
    jq
    just
    kotlin
    libfido2
    libiconv
    mob
    moonlight-qt
    ngrok
    ninja
    nixd
    nixfmt-rfc-style
    nodejs_22
    obsidian
    openssh
    pgcli
    pipx
    plantuml
    pnpm
    procs
    ripgrep
    rm-improved
    rustup
    sd
    sqlite
    terraform
    unzip
    vectorcode
    wget
    # xcp
    xh

    opencode
  ];

  home.sessionPath = [
    "$HOME/.npm-packages/bin"
    "$HOME/.cargo/bin"
    "$HOME/.pnpm"
    "$HOME/.local/bin"
    "${pkgs.graalvm-ce}/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
  ];

  age.identityPaths = [ "/Users/eriksimon/.ssh/id_ed25519" ];
  age.secrets.hoarder.file = ./secrets/default/hoarder.age;

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    PNPM_HOME = "$HOME/.pnpm";
    GRAALVM_HOME = "${pkgs.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvm-ce}";
    TERMINAL = "wezterm";
    HOARDER_SERVER_ADDR = "https://hoarder.stx.wtf";
    HOARDER_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.hoarder.path})";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  programs.bun = {
    enable = true;
  };

  programs.ghostty = {
    enable = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
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

  programs.delta = {
    enable = true;
    options = {
      side-by-side = true;
      line-numbers = true;
    };
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Erik Simon";
        email = "10850738+ShooTeX@users.noreply.github.com";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        ff = "only";
      };
      merge = {
        ff = "only";
      };
      fetch = {
        prune = true;
      };
      init = {
        defaultBranch = "main";
      };
      help = {
        autocorrect = "prompt";
      };
      rerere = {
        enabled = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };

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

      # cp = "xcp";

      cd = "z";
    };

    initContent = ''
      EDITOR=vim
      VISUAL=vim
      eval "$(direnv hook zsh)"
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

  programs.eza = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      character = {
        error_symbol = "[❯](red)";
        success_symbol = "[❯](purple)";
        vimcmd_symbol = "[❮](green)";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      directory = {
        style = "blue";
      };
      format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "bright-black";
      };
      git_status = {
        conflicted = "​";
        deleted = "​";
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        modified = "​";
        renamed = "​";
        staged = "​";
        stashed = "≡";
        style = "cyan";
        untracked = "​";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile = {
    nvim = {
      source = nvim-config;
      recursive = true;
    };
    "wezterm/wezterm.lua" = {
      enable = false;
      source = wezterm-config;
    };
    "wezterm" = {
      source = wezterm-config;
      recursive = true;
    };
  };
}
