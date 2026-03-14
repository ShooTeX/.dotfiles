{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.stateVersion = "24.05";

  imports = [
    inputs.walker.homeManagerModules.default
    ../../common/home
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    gcc
    _1password-gui
    pwvucontrol
  ];

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

    firefox = {
      enable = true;
    };

    ghostty = {
      settings = {
        font-size = 18;
        font-thicken = false;
      };
    };

    walker = {
      enable = true;
      runAsService = true;
    };

  };
}
