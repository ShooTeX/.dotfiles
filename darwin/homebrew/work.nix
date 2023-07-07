{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [ "whatsapp" "tidal" "bitwarden" "discord" "raycast" "gitify" "insomnia" ];
  };
}
