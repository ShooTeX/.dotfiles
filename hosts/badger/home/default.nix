{
  pkgs,
  inputs,
  ...
}:
{
  home.stateVersion = "24.05";

  imports = [
    ../../../modules/home
    inputs.walker.homeManagerModules.default
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    gcc
    _1password-gui
    playerctl
    teamspeak6-client
  ];

  lab = {
    browser.zen.enable = true;
    dev.enable = true;
    terminal.enable = true;
  };

  programs = {
    ghostty = {
      settings = {
        font-size = 14;
        font-thicken = false;
        font-family = "Iosevka Comfy Fixed";
      };
    };

    mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        output_folder = "~/mangohud";
      };
    };
  };
}
