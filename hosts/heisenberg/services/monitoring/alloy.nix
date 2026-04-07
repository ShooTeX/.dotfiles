{ config, ... }:
{
  services.alloy = {
    enable = true;
  };

  environment.etc."alloy/config.alloy".text =
    let
      lokiPort = toString config.services.loki.configuration.server.http_listen_port;
    in
    ''
      loki.source.journal "journal" {
        max_age       = "12h"
        forward_to    = [loki.write.local.receiver]
        relabel_rules = loki.relabel.journal.rules
        labels = {
          job = "systemd-journal",
        }
      }

      loki.relabel "journal" {
        forward_to = []

        rule {
          source_labels = ["__journal__systemd_unit"]
          target_label  = "unit"
        }
        rule {
          source_labels = ["__journal__priority_keyword"]
          target_label  = "level"
        }
        rule {
          source_labels = ["__journal__hostname"]
          target_label  = "host"
        }
      }

      loki.write "local" {
        endpoint {
          url = "http://localhost:${lokiPort}/loki/api/v1/push"
        }
      }
    '';
}
