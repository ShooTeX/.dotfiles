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
    ./dev
    ./secrets
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
    ffmpeg
    gawk
    github-mcp-server
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

  programs.bun = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
