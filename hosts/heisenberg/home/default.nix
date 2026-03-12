{
  home.stateVersion = "24.05";

  programs = {
    nushell = {
      enable = true;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    atuin = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
