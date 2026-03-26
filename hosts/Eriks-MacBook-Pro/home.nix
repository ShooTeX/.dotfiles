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
    shell.defaultShell = "zsh";
    terminal.enable = true;
  };

  programs.claude-code.enable = true;
}
