{
  pkgs,
  ...
}:

{
  imports = [
    ./core
    ./dev
  ];

  home.packages = with pkgs; [
    _1password-cli
    awscli2
    bat
    bottom
    cmake
    d2
    deploy-rs
    dust
    ffmpeg
    gawk
    glow
    gnupg
    grex
    httpie
    hyperfine
    jq
    just
    libiconv
    moonlight-qt
    ngrok
    ninja
    obsidian
    openssh
    pgcli
    plantuml
    procs
    ripgrep
    rm-improved
    sd
    sqlite
    terraform
    unzip
    wget
    xh
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
