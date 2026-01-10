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
  };

  services.caddy.virtualHosts."grafana.dottex.world".extraConfig = ''
    import cf_dns
    reverse_proxy localhost:3000
  '';
}
