{ pkgs, ... }:
{
  home.packages = with pkgs; [
    notion-app
  ];

  home.stateVersion = "22.05";

  lab = {
    dev = {
      enable = true;
      ecosystems.active = [ "terraform" ];
    };
    multiplexer.zellij.enable = true;
    terminal.enable = true;
  };

  programs.claude-code.enable = true;
}
