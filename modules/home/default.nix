{
  imports = [
    ./multiplexer
    ./shell
    ./terminals

    ./cli-goodies.nix
    ./git.nix
  ];

  lab = {
    cli-goodies.enable = true;
    shell.enable = true;
    git.enable = true;
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
