{
  users.users.stx.home = "/Users/stx";

  homebrew.casks = [
    "google-chrome"
    "discord"
    "figma"
    "parsec"
    "teamspeak-client"
    "orcaslicer"
  ];

  system.primaryUser = "stx";

  home-manager.users.stx.imports = [ ../common/home ];
}
