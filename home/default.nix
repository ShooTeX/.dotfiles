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
  ];

  home.packages = with pkgs; [
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
    glow
    gnupg
    grex
    httpie
    hyperfine
    jq
    just
    libfido2
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

  home.sessionVariables = {
    HOARDER_SERVER_ADDR = "https://hoarder.stx.wtf";
    HOARDER_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.hoarder.path})";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
