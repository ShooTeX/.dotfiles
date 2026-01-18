{ config, ... }:
{
  services = {
    immich = {
      enable = true;
    };

    borgmatic.settings = {
      source_directories = [
        config.services.immich.mediaLocation
      ];
      postgresql_databases = [
        {
          inherit (config.services.immich.database) name;
          username = config.services.immich.database.user;
        }
      ];
    };

    caddy.virtualHosts."immich.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.immich.port}
      '';
    };
  };

}
