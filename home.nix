{config, pkgs, lib, nixpkgs, inputs, ... }:

let
  nvchad-config = pkgs.callPackage ./modules/nvchad-config.nix { nvchad = inputs.nvchad; nvim-config = inputs.nvim-config; };
in
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
    gcc
    exa
    bat
    fd
    ripgrep
    hyperfine
    tealdeer
    grex
    zoxide
    unzip
    lazygit
    nodejs
    rustup
    ngrok
    sketchybar
    dart
    git-crypt

    # node
    nodePackages_latest.yarn
    nodePackages_latest.pnpm
  ];

  home.sessionPath = [ "$HOME/.npm-packages/bin"];

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    TERMINAL = "kitty";
  }; 

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  programs.google-chrome.enable = false;

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    settings = {
      macos_option_as_alt = true;
      hide_window_decorations = "titlebar-only";
    };
    font = {
      name = "Iosevka Nerd Font";
      size = 16;
    };
  };

  programs.git = {
    enable = true;

    extraConfig = {
      user = {
        name = "Erik Simon";
        email = "10850738+ShooTeX@users.noreply.github.com";
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
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    autocd = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;

    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      find = "fd";
    };

    initExtra = ''
      EDITOR=vim
      VISUAL=vim
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
      '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [ 
        "[](#9A348E)"
        "$username"
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

      username = {
        show_always = true;
        style_user = "bg:#9A348E";
        style_root = "bg:#9A348E";
        format = "[$user ]($style)";
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
        format = "[ ♥ $time ]($style)";
      };

      nodejs = {
        symbol = "";
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
    source = nvchad-config;
    recursive = true;
  };
}
