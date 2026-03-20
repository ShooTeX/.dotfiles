{ pkgs, ... }:
{
  home.packages = with pkgs; [
    notion-app
  ];

  home.stateVersion = "22.05";

  services.ollama.enable = true;

  lab = {
    multiplexer.zellij.enable = true;
  };
}
