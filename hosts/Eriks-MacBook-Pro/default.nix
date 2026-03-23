{ pkgs, ... }:
{
  system.primaryUser = "stx";
  users.users.stx = {
    home = "/Users/stx";
  };
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];
  home-manager.users.stx.imports = [
    ../../modules/home
    ./home.nix
  ];
  homebrew.brews = [
    "mlx-lm"
  ];
  homebrew.casks = [
    "asana"
    "bruno"
    "discord"
    "google-chrome"
    "granola"
    "kap"
    "slack"
    "tuple"
  ];
  ids.gids.nixbld = 350;

  lab = {
    sops.usingSecurityKey = true;
  };
}
