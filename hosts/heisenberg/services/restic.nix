{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = map lib.lowPrio [
    pkgs.restic
  ];

  sops.secrets = {
    "restic/passphrase" = { };
    "restic/ssh" = { };
  };

  programs.ssh.extraConfig = ''
    Host storagebox
      HostName u533631.your-storagebox.de
      User u533631
      IdentityFile ${config.sops.secrets."restic/ssh".path}
      StrictHostKeyChecking no
      Port 23
  '';

  services = {
    restic.backups.storagebox = {
      repository = "sftp://storagebox/./heisenberg.restic";
      passwordFile = config.sops.secrets."restic/passphrase".path;
      initialize = true;

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
        "--keep-yearly 2"
      ];

      backupPrepareCommand = ''
        mkdir -p /tmp/postgresql-backup
        ${pkgs.util-linux}/bin/runuser -u postgres -- ${pkgs.postgresql}/bin/pg_dumpall -U postgres > /tmp/postgresql-backup/all.sql
      '';

      backupCleanupCommand = ''
        rm -rf /tmp/postgresql-backup
      '';

      paths = [
        "/tmp/postgresql-backup"
      ];
    };

    prometheus.exporters.restic = {
      enable = true;
      inherit (config.services.restic.backups.storagebox)
        repository
        passwordFile
        user
        ;

      refreshInterval = 18000;
    };
  };

  environment.etc."grafana/dashboards/restic.json" = {
    source =
      pkgs.runCommand "restic-dashboard.json"
        {
          nativeBuildInputs = [ pkgs.jq ];
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/ngosang/restic-exporter/refs/tags/2.0.2/grafana/grafana_dashboard.json";
            hash = "sha256-JxVAkbiO/Oxyrw87rb5Sl8E9JwQz5I/+lzRxgaznqn4=";
          };
        }
        ''
          jq '
            del(.__elements) |
            del(.__requires) |
            (.. | objects | select(.type? == "datasource")) .uid = "''${datasource}" |
            (.. | strings | select(. == "''${DS_PROMETHEUS}")) |= "''${datasource}" |
            .templating.list = [{
              "name": "datasource",
              "type": "datasource",
              "query": "prometheus",
              "pluginId": "prometheus",
              "label": "Data Source",
              "refresh": 1,
              "hide": 0,
              "includeAll": false,
              "multi": false
            }] + .templating.list
          ' $src > $out
        '';
  };
}
