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
      "tailscale"
      "whatsapp"
      "yubico-authenticator"
      "ghostty"
    ];
  };
}
