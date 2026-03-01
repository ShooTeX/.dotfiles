{ config, ... }:
{
  services = {
    actual = {
      enable = true;

      settings.port = 3002;
    };

    caddy.virtualHosts."actual.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.actual.settings.port}
      '';
    };

    borgmatic.settings.source_directories = [
      "/var/lib/actual"
    ];
  };
}
