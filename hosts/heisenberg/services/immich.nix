{ config, ... }:
{
  services = {
    immich = {
      enable = true;

      mediaLocation = "/mnt/storage/immich";

      database = {
        enableVectors = false;
      };
    };

    restic.backups.storagebox.paths = [
      config.services.immich.mediaLocation
    ];

    caddy.virtualHosts."immich.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.immich.port}
      '';
    };
  };

}
