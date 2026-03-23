{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.lab.shell.zsh;
in
{
  options.lab.shell.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableZshIntegration = true;

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

        initContent = lib.mkIf pkgs.stdenv.isDarwin ''
          export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.libiconv}/lib
          if [[ $(uname -m) == 'arm64' ]]; then
              eval "$(/opt/homebrew/bin/brew shellenv)"
          fi
        '';
      };

      fzf = {
        enable = true;
      };
    };
  };
}
