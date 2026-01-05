{ pkgs, lib, ... }:
{
  sops = {
    defaultSopsFile = ../core/secrets/shared.enc.json;

    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };

    environment = {
      PATH = "${lib.makeBinPath [ pkgs.age-plugin-yubikey ]}:$PATH";
    };

    secrets = {
      hello = { };
    };
  };

}
