{
  pkgs,
  options,
  ...
}:
{
  home = {
    stateVersion = "22.05";

    packages = with pkgs; [
      awscli2
      notion-app
      opentelemetry-collector-contrib
    ];

    sessionVariables = {
      AWS_PROFILE = "tenant-falkin-dev-admin";
    };
  };

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
