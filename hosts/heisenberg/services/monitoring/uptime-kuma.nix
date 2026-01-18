{ config, ... }:
{
  services = {
    uptime-kuma = {
      enable = true;
      settings = {
        UPTIME_KUMA_PORT = "4251";
      };
    };

    caddy.virtualHosts."uptime-kuma.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.uptime-kuma.settings.UPTIME_KUMA_PORT}
      '';
    };
  };
}
