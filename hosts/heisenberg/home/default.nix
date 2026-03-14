{ pkgs, ... }:
{
  home.stateVersion = "24.05";

  imports = [ ../../common/home/core/shell/starship.nix ];

  programs = {
    nushell = {
      enable = true;
      plugins = [
        pkgs.nushellPlugins.formats
      ];
    };

    starship.enableNushellIntegration = true;

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

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

  };
}
