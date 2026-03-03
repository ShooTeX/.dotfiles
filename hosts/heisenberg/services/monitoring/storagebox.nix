{ config, pkgs, ... }:
{
  sops.secrets = {
    "storagebox/token" = {
    };
  };
  services.prometheus.exporters.storagebox = {
    enable = true;

    tokenFile = config.sops.secrets."storagebox/token".path;
  };

  environment.etc."grafana/dashboards/storagebox-exporter.json" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/crstian19/prometheus-storagebox-exporter/refs/tags/v0.4.2/grafana-provisioning/dashboards/grafana-dashboard.json";
      hash = "sha256-zVx9efoiAyZPRBDhXbpulsAhz/zUaSX+9HEgJHldMv4=";
    };
  };
}
