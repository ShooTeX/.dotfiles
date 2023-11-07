{ config, pkgs, lib, nixpkgs, inputs, ... }:

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
    nixfmt
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
    obsidian
    git-filter-repo
    pscale
    mysql-client
    bitwarden-cli
    wget
    gnused

    # IaC
    terraform

    #kotlin
    kotlin
    gradle
    jdk
    http4k

    #ocaml
    opam

    #latex
    texlive.combined.scheme-full

    #aws
    awscli2

    # node
    bun
    nodejs
    nodePackages_latest.yarn
    nodePackages_latest.pnpm
    nodePackages_latest.vercel

    # security
    libfido2
    openssh
    _1password

    # markdown
    glow
  ];

  home.sessionPath = [ "$HOME/.npm-packages/bin" "$HOME/.cargo/bin" "$HOME/.pnpm" "$HOME/.local/bin" ];

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    PNPM_HOME = "$HOME/.pnpm";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv = { enable = true; };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    settings = {
      shell_integration = true;
      macos_option_as_alt = true;
      hide_window_decorations = "titlebar-only";
    };
    font = {
      name = "Iosevka";
      size = 18;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    extraConfig = ''
# - Use additional nerd symbols
# See https://github.com/be5invis/Iosevka/issues/248
# See https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points

# Seti-UI + Custom
symbol_map U+E5FA-U+E6AC Symbols Nerd Font

# Devicons
symbol_map U+E700-U+E7C5 Symbols Nerd Font

# Font Awesome
symbol_map U+F000-U+F2E0 Symbols Nerd Font

# Font Awesome Extension
symbol_map U+E200-U+E2A9 Symbols Nerd Font

# Material Design Icons
symbol_map U+F0001-U+F1AF0 Symbols Nerd Font

# Weather
symbol_map U+E300-U+E3E3 Symbols Nerd Font

# Octicons
symbol_map U+F400-U+F532,U+2665,U+26A1 Symbols Nerd Font

# Powerline Symbols
symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font

# Powerline Extra Symbols
symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4 Symbols Nerd Font

# IEC Power Symbols
symbol_map U+23FB-U+23FE,U+2B58 Symbols Nerd Font

# Font Logos
symbol_map U+F300-U+F32F Symbols Nerd Font

# Pomicons
symbol_map U+E000-U+E00A Symbols Nerd Font

# Codicons
symbol_map U+EA60-U+EBEB Symbols Nerd Font

# Additional sets
symbol_map U+E276C-U+E2771 Symbols Nerd Font
symbol_map U+2500-U+259F Symbols Nerd Font

# Some symbols not covered by Symbols Nerd Font
# nonicons contains icons in the range: U+F101-U+F27D
# U+F167 is HTML logo, but YouTube logo in Symbols Nerd Font
symbol_map U+F102,U+F116-U+F118,U+F12F,U+F13E,U+F1AF,U+F1BF,U+F1CF,U+F1FF,U+F20F,U+F21F-U+F220,U+F22E-U+F22F,U+F23F,U+F24F,U+F25F nonicons
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
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "exa --icons --color=always --group-directories-first";
      sl = "ls";
      lsa = "ls -a";
      l = "ls -l";
      la = "ls -la";

      s = "kitty +kitten ssh";

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
        symbols = {
          Macos = "";
        };
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
    source = inputs.nvim-config;
    recursive = true;
  };
}
