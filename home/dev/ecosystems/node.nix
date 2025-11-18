{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_22
    pnpm
    husky
  ];

  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/.npm-packages/bin"
    "$HOME/.pnpm"
  ];

  programs.bun = {
    enable = true;
  };
}
