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
    inputs.zen-browser.homeModules.default
    ./hyprland.nix
    ./waybar.nix
    ./browser.nix
  ];

  home.packages = with pkgs; [
    gcc
    _1password-gui
    playerctl
  ];

  lab = {
    terminal.enable = true;
    dev.enable = true;
  };

  services = {
    ollama.enable = true;
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
