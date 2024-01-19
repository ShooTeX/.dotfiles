{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [ "1password" "whatsapp" "raycast" "insomnia" "logi-options-plus" "slack" "tuple" ];
    brews = [ "netlify-cli" ];
  };
}
