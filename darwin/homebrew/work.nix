{ ... }:
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
      "insomnia"
      "kap"
      "nordlayer"
      "orbstack"
      "raycast"
      "slack"
      "tuple"
      "whatsapp"
    ];
    brews = [
      "luajit" # for neorg
    ];
  };
}
