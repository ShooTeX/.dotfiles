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
  };
}
