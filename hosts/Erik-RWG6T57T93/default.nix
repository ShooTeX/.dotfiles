{
  imports = [
    ../common/core
    ../common/darwin
    ./darwin
  ];

  home-manager.users.eriksimon.imports = [ ../common/home ];
}
