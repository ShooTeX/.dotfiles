{ config, ... }:
{
  sops.secrets = {
    "borgmatic/passphrase" = {
      restartUnits = [ "borgmatic.service" ];
    };
    "borgmatic/ssh" = {
      restartUnits = [ "borgmatic.service" ];
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

      ssh_command = "ssh -p 23 -i ${config.sops.secrets."borgmatic/ssh".path}";

      encryption_passcommand = "cat ${config.sops.secrets."borgmatic/passphrase".path}";

      retention = {
        keep_daily = 7;
        keep_weekly = 4;
        keep_monthly = 6;
        keep_yearly = 2;
      };

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
