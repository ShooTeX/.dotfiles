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
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };

      # hdd1 = {
      #   device = lib.mkDefault "/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35JKF";
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       storage = {
      #         size = "100%";
      #         content = {
      #           type = "btrfs";
      #           extraArgs = [
      #             "-m raid1"
      #             "-d raid1"
      #             "--label storage"
      #             "--force"
      #           ];
      #           mountpoint = "/mnt/storage";
      #           mountOptions = [
      #             "defaults"
      #             "compress=zstd"
      #             "noatime"
      #           ];
      #         };
      #       };
      #     };
      #   };
      # };
      #
      # hdd2 = {
      #   device = lib.mkDefault "/dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35MJ5";
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       storage = {
      #         size = "100%";
      #         content = {
      #           type = "btrfs";
      #           extraArgs = [
      #             "-m raid1"
      #             "-d raid1"
      #             "--label storage"
      #             "--force"
      #           ];
      #         };
      #       };
      #     };
      #   };
      # };

    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
