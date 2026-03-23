{ pkgs, ... }:
{
  home.packages = with pkgs; [
    notion-app
  ];

  home.stateVersion = "22.05";

  # services.ollama.enable = true;

  lab = {
    dev.enable = true;
    multiplexer.zellij.enable = true;
    shell.defaultShell = "zsh";
    terminal.enable = true;
  };
}
