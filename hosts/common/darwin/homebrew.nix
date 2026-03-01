{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "1password"
      "orbstack"
      "raycast"
      "whatsapp"
      "yubico-authenticator"
      "ghostty"
    ];
  };
}
