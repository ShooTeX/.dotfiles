{ config, lib, ... }:
{
  sops.secrets = {
    "mealie/env" = { };
  };
  services = {
    mealie = {
      enable = true;

      credentialsFile = config.sops.secrets."mealie/env".path;
      settings = {
        TZ = "Europe/Berlin";
        BASE_URL = "https://mealie.dottex.world";
        OPENAI_MODEL = "gpt-5-nano";
      };
    };

    caddy.virtualHosts."${lib.removePrefix "https://" config.services.mealie.settings.BASE_URL}" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.mealie.port}
      '';
    };

    restic.backups.storagebox.paths = [
      "/var/lib/mealie"
    ];
  };

}
