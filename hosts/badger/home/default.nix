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
    inputs.zen-browser.homeModules.default
    ../../common/home
    ./hyprland.nix
    ./waybar.nix
    ./browser.nix
  ];

  home.packages = with pkgs; [
    gcc
    _1password-gui
    playerctl
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

    ghostty = {
      settings = {
        font-size = 14;
        font-thicken = false;
        font-family = "Iosevka Comfy Fixed";
      };
    };

    mangohud.enable = true;
  };
}
