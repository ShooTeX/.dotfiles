{ config, ... }:
{
  services.adguardhome = {
    enable = true;

    settings = { };
    port = 3001;
  };

  services.caddy.virtualHosts = {
    "adguard.dottex.world" = {
      useACMEHost = "dottex.world";
      extraConfig = ''
        reverse_proxy localhost:${toString config.services.adguardhome.port}
      '';
    };
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}
