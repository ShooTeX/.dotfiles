{ config, ... }:
{
  services = {
    adguardhome = {
      enable = true;

      settings = { };
      port = 3001;
    };

    caddy.virtualHosts = {
      "adguard.dottex.world" = {
        useACMEHost = "dottex.world";
        extraConfig = ''
          reverse_proxy localhost:${toString config.services.adguardhome.port}
        '';
      };
    };

    borgmatic.settings = {
      source_directories = [
        "/var/lib/AdGuardHome/AdGuardHome.yaml"
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}
