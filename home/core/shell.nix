{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-crypt
  ];

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

      ip = "ip --color=auto";

      find = "fd";

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

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
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
}
