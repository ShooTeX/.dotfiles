{ config, ... }:
{
  sops.secrets.homepage = {
    format = "dotenv";
    sopsFile = ../secrets/homepage.enc.env;
    key = "";
  };

  services.homepage-dashboard = {
    enable = true;
    environmentFile = config.sops.secrets.homepage.path;

    allowedHosts = "dottex.world";

    settings = {
      title = "DOTTEX World";
    };

    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];

    services = [
      {
        Monitoring = [
          {
            Grafana = {
              icon = "https://upload.wikimedia.org/wikipedia/commons/3/3b/Grafana_icon.svg";
              description = "Monitoring Dashboards";
              href = "https://grafana.dottex.world";
            };
          }
        ];
      }
    ];
  };

  services.caddy.virtualHosts."dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:${toString config.services.homepage-dashboard.listenPort}
    '';
  };

}
