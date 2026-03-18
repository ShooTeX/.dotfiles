{
  imports = [
    ./fonts.nix
    ./nix.nix
    ./sops.nix
  ];

  lab = {
    sops.enable = true;
    fonts.enable = true;
    nix.enable = true;
  };
}
