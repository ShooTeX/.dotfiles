{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.default
    ./browser
    ./dev
    ./multiplexer
    ./shell
    ./terminals

    ./cli-goodies.nix
    ./git.nix
    ./misc.nix
    ./sops.nix
  ];

  lab = {
    cli-goodies.enable = true;
    git.enable = true;
    misc.enable = true;
    shell.enable = true;
  };

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    zoxide = {
      enable = true;
    };

    eza = {
      enable = true;
    };

    atuin = {
      enable = true;
    };
  };
}
