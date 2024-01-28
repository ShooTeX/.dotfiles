{ config, pkgs, lib, nixpkgs, nvim-config, ... }:

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
    wget
    gnused
    husky
    gitleaks
    plantuml

    #
    qemu
    podman

    # IaC
    terraform

    #kotlin
    kotlin
    http4k
    graalvm-ce
    (
      (gradle.override
        { java = graalvm-ce; })
    )

    #ocaml
    opam

    #latex
    texlive.combined.scheme-full

    #aws
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
  ];

  home.sessionPath = [ "$HOME/.npm-packages/bin" "$HOME/.cargo/bin" "$HOME/.pnpm" "$HOME/.local/bin" "${pkgs.graalvm-ce}/bin" ];

  home.sessionVariables = {
    NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    PNPM_HOME = "$HOME/.pnpm";
    GRAALVM_HOME = "${pkgs.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvm-ce}";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv = { enable = true; };
  };

  programs.kitty = (import ./home/common/programs/kitty.nix).kitty;

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

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = nvim-config;
    recursive = true;
  };
}
