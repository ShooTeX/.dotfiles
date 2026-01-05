{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    age
    age-plugin-yubikey
    libfido2
    sops
    yubikey-manager
  ];

  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
  };
}
