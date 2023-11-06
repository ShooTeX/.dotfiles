{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [ "whatsapp" "raycast" "gitify" "insomnia" "logi-options-plus" "slack" "tuple" ];
  };
}
