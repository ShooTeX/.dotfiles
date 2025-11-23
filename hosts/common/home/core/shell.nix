{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-crypt
  ];

  programs = {
    zsh = {
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

    zellij = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        theme = "kanagawa";
        keybinds = {
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
      };
    };

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
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
  };
}
