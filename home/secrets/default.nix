{ pkgs, ... }:
{
  home.packages = with pkgs; [
    agenix-cli
  ];
  age.identityPaths = [ "/Users/eriksimon/.ssh/id_ed25519" ];
  age.secrets.hoarder.file = ./default/hoarder.age;
}
