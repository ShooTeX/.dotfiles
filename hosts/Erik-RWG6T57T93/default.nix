{
  imports = [
    ../common/core
    ../common/darwin
    ./darwin
  ];

  users.users.eriksimon.home = "/Users/eriksimon";
  home-manager.users.eriksimon.imports = [ ../common/home ];
}
