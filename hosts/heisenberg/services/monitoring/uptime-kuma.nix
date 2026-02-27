{ config, ... }:
{
  services = {
    uptime-kuma = {
      enable = true;
      settings = {
        PORT = "4251";
      };
    };

    borgmatic.settings = {
      source_directories = [
        config.services.uptime-kuma.settings.DATA_DIR
      ];
    };

    caddy.virtualHosts."uptime-kuma.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.uptime-kuma.settings.PORT}
      '';
    };
  };
}
