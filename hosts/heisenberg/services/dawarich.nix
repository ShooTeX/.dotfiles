{ config, ... }:
{
  sops.secrets = {
    "dawarich/secret_key_base" = { };
    "dawarich/postgress_password" = { };
    "dawarich/env" = { };
  };

  # https://github.com/NixOS/nixpkgs/pull/423867
  services.dawarich = {
    enable = false;

    configureNginx = false;
    webPort = 5897;
    localDomain = "dawarich.dottex.world";
    secretKeyBaseFile = config.sops.secrets."dawarich/secret_key_base".path;

    database = {
      passwordFile = config.sops.secrets."dawarich/postgress_password".path;
    };

    environment = {
      PHOTON_API_HOST = "photon.dawarich.app";
    };

    extraEnvFiles = [
      config.sops.secrets."dawarich/env".path
    ];
  };

  services.caddy.virtualHosts."dawarichbald.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:${toString config.services.dawarich.webPort}
    '';
  };
}
