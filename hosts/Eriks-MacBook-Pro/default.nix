{
  system.primaryUser = "stx";
  users.users.stx.home = "/Users/stx";
  home-manager.users.stx.imports = [
    ../common/home
    ./home.nix
  ];
  homebrew.casks = [
    "asana"
    "discord"
    "google-chrome"
    "kap"
    "slack"
    "tuple"
    "granola"
    "bruno"
  ];
  ids.gids.nixbld = 350;

  lab = {
    sops.usingSecurityKey = true;
  };
}
