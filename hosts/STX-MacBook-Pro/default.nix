{
  imports = [
    ../common/core
    ../common/darwin
    ./darwin
  ];

  users.users.stx.home = "/Users/eriksimon";

  home-manager.users.stx.imports = [ ../common/home ];
}
