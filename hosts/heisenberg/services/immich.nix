{ config, ... }:
{
  services.immich = {
    enable = true;
  };

  services.caddy.virtualHosts."immich.dottex.world".extraConfig = ''
    import cf_dns
    reverse_proxy localhost:${toString config.services.immich.port}
  '';
}
