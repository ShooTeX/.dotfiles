let
  shares_dir = "/mnt/storage/shares";
in
{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "netbios name" = "DOTTEX-WORLD";
          "server string" = "DOTTEX WORLD";
          "workgroup" = "WORKGROUP";
          "server role" = "standalone server";
          "client min protocol" = "SMB2";
          "server min protocol" = "SMB2";
          "fruit:metadata" = "stream";
          "fruit:model" = "MacSamba";
          "fruit:posix_rename" = "yes";
          "fruit:veto_appledouble" = "no";
          "fruit:wipe_intentionally_left_blank_rfork" = "yes";
          "fruit:delete_empty_adfiles" = "yes";
        };
        stx = {
          path = "${shares_dir}/stx";
          browseable = "yes";
          writeable = "yes";
          "valid users" = "stx";
          "vfs objects" = "catia fruit streams_xattr";
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
          "vfs objects" = "catia fruit streams_xattr";
        };
        public = {
          path = "${shares_dir}/public";
          browseable = "yes";
          writeable = "no";
          "guest ok" = "yes";
        };
      };
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    restic.backups.storagebox.paths = [ shares_dir ];
  };

  systemd.tmpfiles.rules = [
    "d ${shares_dir}/stx             0711 stx   stx    -"
    "d ${shares_dir}/stx/pictures    0770 stx   immich -"
    "d ${shares_dir}/punkt           0700 punkt punkt  -"
    "d ${shares_dir}/shared          0770 root  dottex -"
    "d ${shares_dir}/public          0755 root  root   -"
  ];

}
