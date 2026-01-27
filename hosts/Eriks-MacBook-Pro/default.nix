{ lib, ... }:
{
  imports = [
    ../common/core
    ../common/darwin
    ./darwin
  ];

  users.users.stx.home = "/Users/stx";
  home-manager.users.stx.imports = [
    ../common/home
    ./home
  ];
  ids.gids.nixbld = lib.mkForce 350;
}
