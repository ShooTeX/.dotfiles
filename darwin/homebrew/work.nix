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
      "whatsapp"
      "raycast"
      "insomnia"
      "slack"
      "tuple"
      "meetingbar"
      "nordlayer"
    ];
    brews = [
      "luajit" # for neorg
    ];
  };
}
