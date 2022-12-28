{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [ "alfred" "google-chrome" "tidal" "bitwarden" "discord" "parsec" ];
  };
}
