{ ... }: {
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
      "meetingbar"
      "nordlayer"
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
