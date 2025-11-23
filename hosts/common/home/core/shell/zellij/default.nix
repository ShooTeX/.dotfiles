{
  imports = [ ./keybinds.nix ];

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    exitShellOnExit = true;

    settings = {
      theme = "kanagawa";
      show_startup_tips = false;

      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };

    };
  };
}
