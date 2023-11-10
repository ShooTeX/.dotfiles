{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [ "openssl@1.1" ];
    casks = [ "whatsapp" "google-chrome" "tidal" "discord" "parsec" "raycast" "insomnia" "teamspeak-client" ];
  };
}
