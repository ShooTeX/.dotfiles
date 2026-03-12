{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./users.nix
    ./sops.nix
    ./services
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
        "stx"
      ];
    };
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.ffmpeg
  ];

  networking.hostName = "heisenberg";

  system.stateVersion = "24.05";

  systemd.services.hdparm-disks = {
    description = "Set HDD power management settings";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "hdparm-disks" ''
        ${pkgs.hdparm}/sbin/hdparm -B 127 -S 120 /dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35JKF
        ${pkgs.hdparm}/sbin/hdparm -B 127 -S 120 /dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35MJ5
      '';
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  hardware.bluetooth.enable = true;

  services = {
    openssh.enable = true;
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/mnt/storage" ];
    };
  };
}
