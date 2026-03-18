{
  imports = [
    ../common/darwin
    ./darwin
  ];

  users.users.stx.home = "/Users/stx";

  home-manager.users.stx.imports = [ ../common/home ];
}
