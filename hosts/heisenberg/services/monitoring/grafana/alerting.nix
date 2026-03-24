{ config, ... }:
{
  services.grafana.provision.alerting = {
    contactPoints.settings = {
      contactPoints = [
        {
          name = "default";
          receivers = [
            {
              uid = "discord";
              type = "discord";
              settings = {
                url = "$__file{${config.sops.secrets."grafana/alerting_webhook".path}}";
                message = "{{ template \"discord.message\" . }}"; # reference it here
              };
            }
          ];
        }
      ];
    };

    templates.settings = {
      apiVersion = 1;
      templates = [
        {
          name = "discord.message";
          template = ''
            {{ define "discord.message" }}
            {{ range .Alerts }}
            **{{ .Status | toUpper }}** - {{ .Labels.alertname }}
            {{ if .Annotations.summary }}> {{ .Annotations.summary }}{{ end }}
            {{ end }}
            {{ end }}
          '';
        }
      ];
    };

    policies.settings = {
      apiVersion = 1;
      policies = [
        {
          orgId = 1;
          receiver = "default";
          group_by = [
            "grafana_folder"
            "alertname"
          ];
          routes = [ ];
          group_wait = "30s";
          group_interval = "5m";
          repeat_interval = "12h";
        }
      ];
    };

    rules.settings = {
      apiVersion = 1;
      groups = [
        {
          name = "heisenberg";
          folder = "Alerts";
          interval = "5m";
          rules = [
            {
              uid = "disk-limit";
              title = "Disk usage above 70%";
              condition = "A";
              for = "5m";
              noDataState = "NoData";
              execErrState = "Alerting";
              annotations = {
                summary = "Disk usage is above 70% on {{ $labels.mountpoint }}";
              };
              data = [
                {
                  refId = "A";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "-100";
                  model = {
                    type = "math";
                    expression = "$B > 0.7";
                    refId = "A";
                  };
                }
                {
                  refId = "B";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "P4169E866C3094E38";
                  model = {
                    expr = "1 - (node_filesystem_avail_bytes{fstype!~\"tmpfs|overlay\"} / node_filesystem_size_bytes{fstype!~\"tmpfs|overlay\"})";
                    refId = "B";
                    instant = true;
                  };
                }
              ];
            }
            {
              uid = "systemd-unit-failed";
              title = "Systemd unit failed";
              condition = "A";
              for = "2m";
              noDataState = "NoData";
              execErrState = "Alerting";
              annotations = {
                summary = "Systemd unit {{ $labels.name }} has failed";
              };
              data = [
                {
                  refId = "A";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "-100";
                  model = {
                    type = "math";
                    expression = "$B > 0";
                    refId = "A";
                  };
                }
                {
                  refId = "B";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "P4169E866C3094E38";
                  model = {
                    expr = "node_systemd_unit_state{state=\"failed\"}";
                    refId = "B";
                    instant = true;
                  };
                }
              ];
            }
            {
              uid = "error-rate";
              title = "High log error rate";
              condition = "A";
              for = "5m";
              noDataState = "NoData";
              execErrState = "Alerting";
              annotations = {
                summary = "Elevated error rate in systemd journal";
              };
              data = [
                {
                  refId = "B";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "P8E80F9AEF21F6940";
                  model = {
                    expr = "sum(rate({job=\"systemd-journal\"} | detected_level=`error` [5m])) or on() group_left vector(0)";
                    refId = "B";
                    instant = false;
                    queryType = "range";
                  };
                }
                {
                  refId = "C";
                  datasourceUid = "-100";
                  model = {
                    type = "reduce";
                    expression = "B";
                    reducer = "last";
                    refId = "C";
                  };
                }
                {
                  refId = "A";
                  datasourceUid = "-100";
                  model = {
                    type = "math";
                    expression = "$C > 0.1";
                    refId = "A";
                  };
                }
              ];
            }

            {
              uid = "restic-check-failed";
              title = "Restic check failed";
              condition = "A";
              for = "0s";
              noDataState = "Alerting";
              execErrState = "Alerting";
              annotations = {
                summary = "Restic repository check failed";
              };
              data = [
                {
                  refId = "B";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "P4169E866C3094E38";
                  model = {
                    expr = "restic_check_success";
                    refId = "B";
                    instant = true;
                  };
                }
                {
                  refId = "C";
                  datasourceUid = "-100";
                  model = {
                    type = "reduce";
                    expression = "B";
                    reducer = "last";
                    refId = "C";
                  };
                }
                {
                  refId = "A";
                  datasourceUid = "-100";
                  model = {
                    type = "math";
                    expression = "$C == 0";
                    refId = "A";
                  };
                }
              ];
            }
            {
              uid = "restic-backup-stale";
              title = "Restic backup stale";
              condition = "A";
              for = "1d";
              noDataState = "Alerting";
              execErrState = "Alerting";
              annotations = {
                summary = "Restic backup hasn't run in over 24 hours";
              };
              data = [
                {
                  refId = "B";
                  relativeTimeRange = {
                    from = 300;
                    to = 0;
                  };
                  datasourceUid = "P4169E866C3094E38";
                  model = {
                    expr = "time() - max(restic_backup_timestamp)";
                    refId = "B";
                    instant = true;
                  };
                }
                {
                  refId = "C";
                  datasourceUid = "-100";
                  model = {
                    type = "reduce";
                    expression = "B";
                    reducer = "last";
                    refId = "C";
                  };
                }
                {
                  refId = "A";
                  datasourceUid = "-100";
                  model = {
                    type = "math";
                    expression = "$C > 86400";
                    refId = "A";
                  };
                }
              ];
            }
            # {
            #   uid = "storagebox-disk-usage";
            #   title = "Storagebox disk usage above 70%";
            #   condition = "A";
            #   for = "5m";
            #   noDataState = "Alerting";
            #   execErrState = "Alerting";
            #   annotations = {
            #     summary = "Storagebox disk usage is above 70%";
            #   };
            #   data = [
            #     {
            #       refId = "B";
            #       relativeTimeRange = {
            #         from = 300;
            #         to = 0;
            #       };
            #       datasourceUid = "P4169E866C3094E38";
            #       model = {
            #         expr = "storagebox_disk_usage / storagebox_disk_quota";
            #         refId = "B";
            #         instant = true;
            #       };
            #     }
            #     {
            #       refId = "C";
            #       datasourceUid = "-100";
            #       model = {
            #         type = "reduce";
            #         expression = "B";
            #         reducer = "last";
            #         refId = "C";
            #       };
            #     }
            #     {
            #       refId = "A";
            #       datasourceUid = "-100";
            #       model = {
            #         type = "math";
            #         expression = "$C > 0.7";
            #         refId = "A";
            #       };
            #     }
            #   ];
            # }
          ];
        }
      ];
    };
  };
}
