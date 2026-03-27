{
  pkgs,
  options,
  ...
}:
{
  home.packages = with pkgs; [
    notion-app
    awscli2
  ];

  home.stateVersion = "22.05";

  lab = {
    dev = {
      enable = true;
      ecosystems.active = options.lab.dev.ecosystems.active.default ++ [ "terraform" ];
    };

    browser.zen.enable = true;
    multiplexer.zellij.enable = true;
    terminal.enable = true;
  };

  programs.claude-code.enable = true;
}
