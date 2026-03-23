{
  config,
  lib,
  ...
}:

let
  cfg = config.lab.multiplexer.zellij;
in
{
  imports = [
    ./keybinds.nix
    ./layouts
  ];

  options.lab.multiplexer.zellij = {
    enable = lib.mkEnableOption "Enable zellij multiplexer";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      exitShellOnExit = true;
      enableZshIntegration = config.lab.shell.defaultShell == "zsh";

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
  };
}
