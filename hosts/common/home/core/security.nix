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
}
