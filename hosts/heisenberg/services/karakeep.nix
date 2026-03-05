{ config, lib, ... }:
{
  sops.secrets = {
    "karakeep/env" = { };
  };
  services = {
    karakeep = {
      enable = true;
      environmentFile = config.sops.secrets."karakeep/env".path;
      extraEnvironment = {
        PORT = "4555";
        NEXTAUTH_URL = "https://karakeep.dottex.world";
      };
    };

    caddy.virtualHosts."${lib.removePrefix "https://" config.services.karakeep.extraEnvironment.NEXTAUTH_URL}" =
      {
        useACMEHost = "dottex.world";
        extraConfig = ''
          reverse_proxy localhost:${toString config.services.karakeep.extraEnvironment.PORT}
        '';
      };

    restic.backups.storagebox.paths = [
      "/var/lib/karakeep"
    ];
  };
}
