{
  imports = [
    ../common/core
    ../common/darwin
    ./darwin
  ];

  home-manager.users.stx.imports = [ ../common/home ];
}
