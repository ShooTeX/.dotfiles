{ lib, ... }:
{
  disko.devices = {
    disk = {
      system = {
        device = lib.mkDefault "/dev/disk/by-id/nvme-WD_BLACK_SN850X_1000GB_25362Q400052";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            windows = {
              name = "windows";
              size = "200G";
              type = "0700";
            };
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
