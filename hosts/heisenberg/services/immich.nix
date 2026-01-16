{ config, ... }:
{
  services.immich = {
    enable = true;
  };

  services.caddy.virtualHosts."immich.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:${toString config.services.immich.port}
    '';
  };
}
