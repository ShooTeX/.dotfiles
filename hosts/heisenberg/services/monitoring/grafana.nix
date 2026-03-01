{ config, pkgs, ... }:
{
  sops.secrets =
    let
      owner = "grafana";
    in
    {
      "grafana/secret_key" = {
        inherit owner;
      };
      "grafana/admin_pass" = {
        inherit owner;
      };
    };
  services.grafana = {
    enable = true;
    settings = {
      security = {
        secret_key = "$__file{${config.sops.secrets."grafana/secret_key".path}}";
        admin_user = "admin";
        admin_password = "$__file{${config.sops.secrets."grafana/admin_pass".path}}";
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
              name = "VictoriaMetrics";
              type = "prometheus";
              url = "http://${config.services.victoriametrics.listenAddress}";
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

      dashboards.settings.providers = [
        {
          options.path = "/etc/grafana/dashboards";
        }
      ];
    };
  };

  environment.etc."grafana/dashboards/node-exporter.json" = {
    source = pkgs.fetchurl {
      url = "https://grafana.com/api/dashboards/1860/revisions/42/download";
      hash = "sha256-pNgn6xgZBEu6LW0lc0cXX2gRkQ8lg/rer34SPE3yEl4=";
    };
  };

  services.caddy.virtualHosts."grafana.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:3000
    '';
  };
}
