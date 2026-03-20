{
  imports = [ ./cli-goodies.nix ];

  lab = {
    cli-goodies.enable = true;
  };

  programs.home-manager.enable = true;
}
