{ pkgs, ... }:

{
  imports = [
    ./zellij
    ./starship.nix
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
        export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.libiconv}/lib
        if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;

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

  };
}
