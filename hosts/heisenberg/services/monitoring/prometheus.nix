{ config, ... }:
{
  services.prometheus = {
    enable = true;
    port = 9000;
    exporters = {
      node = {
        enable = true;
        port = 9001;
        enabledCollectors = [
          "ethtool"
          "tcpstat"
          "systemd"
        ];
      };
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
    ];
  };
}
