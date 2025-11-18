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
    obsidian
    openssh
    pgcli
    pipx
    plantuml
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
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "${pkgs.graalvmPackages.graalvm-ce}/bin"
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    GRAALVM_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
    HOARDER_SERVER_ADDR = "https://hoarder.stx.wtf";
    HOARDER_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.hoarder.path})";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
