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

  services = {
    restic.backups.storagebox = {
      repository = "sftp://u533631@u533631.your-storagebox.de:23/./heisenberg.restic";
      passwordFile = config.sops.secrets."restic/passphrase".path;
      initialize = true;

      extraOptions = [
        "sftp.args=\"-i ${config.sops.secrets."restic/ssh".path} -o StrictHostKeyChecking=no\""
      ];

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
  };
}
