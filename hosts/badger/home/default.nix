{ pkgs, lib, ... }:
{
  home.stateVersion = "24.05";

  imports = [ ../../common/home ];

  programs = {
    nushell = {
      enable = true;
      plugins = [
        pkgs.nushellPlugins.formats
      ];
    };

    zsh = {
      enable = lib.mkForce false;
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
