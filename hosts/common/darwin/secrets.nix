{ pkgs, lib, ... }:
{
  sops = {
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };

    environment = {
      PATH = "${lib.makeBinPath [ pkgs.age-plugin-yubikey ]}:$PATH";
    };
  };
}
