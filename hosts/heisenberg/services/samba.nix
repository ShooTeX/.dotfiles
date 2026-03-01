let
  shares_dir = "/mnt/storage/shares";
in
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "netbios name" = "DOTTEX-WORLD";
        "workgroup" = "WORKGROUP";
        "server string" = "heisenberg";
        "server role" = "standalone server";
        "log level" = "1";
      };
      stx = {
        path = "${shares_dir}/stx";
        browseable = "yes";
        writeable = "yes";
        "valid users" = "stx";
      };
      punkt = {
        path = "${shares_dir}/punkt";
        browseable = "yes";
        writeable = "yes";
        "valid users" = "punkt";
      };
      shared = {
        path = "${shares_dir}/shared";
        browseable = "yes";
        writeable = "yes";
        "valid users" = "stx punkt";
      };
      public = {
        path = "${shares_dir}/public";
        browseable = "yes";
        writeable = "no";
        "guest ok" = "yes";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d ${shares_dir}/stx             0711 stx   stx    -"
    "d ${shares_dir}/stx/pictures    0770 stx   immich -"
    "d ${shares_dir}/punkt           0700 punkt punkt  -"
    "d ${shares_dir}/shared          0770 root  dottex -"
    "d ${shares_dir}/public          0755 root  root   -"
  ];

  services.borgmatic.settings = {
    source_directories = [
      shares_dir
    ];
  };

}
