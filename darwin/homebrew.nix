{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [ "alfred" "google-chrome" "tidal" "bitwarden" "discord" ];
  };
}
