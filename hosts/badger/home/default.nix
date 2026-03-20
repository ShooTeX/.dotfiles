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
