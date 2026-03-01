{ config, ... }:
{
  services.prometheus.exporters.node = {
    enable = true;
    port = 9001;
    enabledCollectors = [
      "ethtool"
      "tcpstat"
      "btrfs"
    ];
  };

  services.victoriametrics = {
    enable = true;
    prometheusConfig = {
      scrape_configs = [
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
  };
}
