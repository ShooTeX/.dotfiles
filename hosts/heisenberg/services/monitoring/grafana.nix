{ config, ... }:
{
  sops.secrets = {
    "grafana/secret_key" = { };
  };
  services.grafana = {
    enable = true;
    settings = {
      security = {
        secret_key = "$__{${config.sops.secrets."grafana/secret_key".path}}";
      };
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

      datasources = {
        settings = {
          datasources = [
            {
              name = "Prometheus";
              type = "prometheus";
              url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
              isDefault = true;
              editable = false;
            }
            {
              name = "Loki";
              type = "loki";
              url = "http://${toString config.services.loki.configuration.server.http_listen_address}:${toString config.services.loki.configuration.server.http_listen_port}";
              editable = false;
            }
          ];
        };
      };
    };
  };

  services.caddy.virtualHosts."grafana.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:3000
    '';
  };
}
