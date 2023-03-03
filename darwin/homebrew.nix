{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [ "openssl@1.1" ];
    casks = [ "google-chrome" "tidal" "bitwarden" "discord" "parsec" "raycast" ];
  };
}
