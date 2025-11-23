{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nodejs_22
      pnpm
      husky
    ];

    sessionPath = [
      "$HOME/.bun/bin"
      "$HOME/.npm-packages/bin"
      "$HOME/.pnpm"
    ];

    sessionVariables = {
      NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
      PNPM_HOME = "$HOME/.pnpm";
    };
  };

  programs.bun = {
    enable = true;
  };
}
