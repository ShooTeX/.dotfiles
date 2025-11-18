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

  imports = [
    ./core
  ];

  home.packages = with pkgs; [
    (gradle.override { java = graalvmPackages.graalvm-ce; })
    _1password-cli
    agenix-cli
    awscli2
    bat
    bottom
    cmake
    d2
    dogdns
    dust
    fd
    ffmpeg
    gawk
    git-crypt
    github-mcp-server
    gitleaks
    glow
    gnupg
    go
    graalvmPackages.graalvm-ce
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
    "${pkgs.graalvmPackages.graalvm-ce}/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
  ];

  age.identityPaths = [ "/Users/eriksimon/.ssh/id_ed25519" ];
  age.secrets.hoarder.file = ./secrets/default/hoarder.age;

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    PNPM_HOME = "$HOME/.pnpm";
    GRAALVM_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
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
