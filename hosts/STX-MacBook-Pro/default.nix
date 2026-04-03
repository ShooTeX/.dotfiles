{
  users.users.stx.home = "/Users/stx";

  homebrew.casks = [
    "ableton-live-suite"
    "discord"
    "figma"
    "google-chrome"
    "orcaslicer"
    "parsec"
    "teamspeak-client"
  ];

  system.primaryUser = "stx";

  lab = {
    sops.usingSecurityKey = true;
  };

  ids.gids.nixbld = 30000;

  home-manager.users.stx.imports = [
    ../../modules/home
    ./home.nix
  ];

}
