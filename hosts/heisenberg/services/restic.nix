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
    };
  };

  environment.etc."grafana/dashboards/restic.json" = {
    source =
      pkgs.runCommand "restic-dashboard.json"
        {
          nativeBuildInputs = [ pkgs.jq ];
          src = pkgs.fetchurl {
            url = "https://grafana.com/api/dashboards/17554/revisions/3/download";
            hash = "sha256-jMv2ag4DlA4Bx+szNFEVF+WrBipICMx1D9uy/oD5Blw=";
          };
        }
        ''
          jq '
            del(.__inputs) |
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
