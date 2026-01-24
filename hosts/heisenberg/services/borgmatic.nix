{ config, ... }:
{
  sops.secrets = {
    borg-passphrase = {
      format = "binary";
      sopsFile = ../secrets/borgmatic.passphrase.enc;
    };
    borg-ssh-key = {
      format = "binary";
      sopsFile = ../secrets/borgmatic.ssh.enc;
    };
  };

  services.borgmatic = {
    enable = true;

    settings = {
      repositories = [
        {
          label = "storagebox";
          path = "ssh://u533631@u533631.your-storagebox.de/./heisen.borg";
        }
      ];

      ssh_command = "ssh -p 23 -i ${config.sops.secrets.borg-ssh-key.path}";

      encryption_passcommand = "cat ${config.sops.secrets.borg-passphrase.path}";

      uptime_kuma = {
        push_url = "https://uptime-kuma.dottex.world/api/push/qTbDvvoKF5pbeKV4RZDKOyg2NqRBgdFi";
        states = [
          "start"
          "finish"
          "fail"
        ];
      };
    };
  };
}
