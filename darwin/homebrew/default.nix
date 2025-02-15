{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "openssl@1.1"
      "luajit" # for neorg
    ];
    casks = [
      "1password"
      "discord"
      "elmedia-player"
      "figma"
      "google-chrome"
      "insomnia"
      "orbstack"
      "parsec"
      "raycast"
      "stremio"
      "tailscale"
      "teamspeak-client"
      "whatsapp"
      "yubico-authenticator"
    ];
  };
}
