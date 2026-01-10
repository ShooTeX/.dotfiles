{ config, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = 3000;
        enforce_domain = true;
        enable_gzip = true;
        domain = "grafana.dottex.world";
      };
      analytics.reporting_enabled = false;
    };

    provision = {
      enable = true;

      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
          isDefault = true;
          editable = false;
        }
      ];
    };
  };

  services.caddy.virtualHosts."grafana.dottex.world".extraConfig = ''
    import cf_dns
    reverse_proxy localhost:3000
  '';
}
