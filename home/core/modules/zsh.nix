{ pkgs, ... }:

{
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
}
