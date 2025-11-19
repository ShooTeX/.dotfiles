{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pipx
  ];
}
