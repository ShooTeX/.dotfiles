{ lib, pkgs, ... }:
{
  environment.etc."sops-key.txt" = {
    text = ''
      AGE-PLUGIN-YUBIKEY-18TMGYQVZSD0W33SXG6T7T
      AGE-PLUGIN-YUBIKEY-1MLP8SQVZSU9SEWSTDSSM4
    '';
  };
  environment.systemPackages = [
    pkgs.age-plugin-yubikey
    pkgs.age
    pkgs.sops
  ];

  services.pcscd.enable = true;

  sops = {
    age = {
      keyFile = "/etc/sops-key.txt";
      generateKey = false;
    };

    environment = {
      PATH = "${lib.makeBinPath [ pkgs.age-plugin-yubikey ]}:$PATH";
    };
    defaultSopsFile = ./secrets/main.enc.yaml;
  };
}
