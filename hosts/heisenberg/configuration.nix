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
  services.openssh.enable = true;

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
  ];

  networking.hostName = "heisenberg";

  system.stateVersion = "24.05";

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -B 127 -S 120 /dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35JKF
    ${pkgs.hdparm}/sbin/hdparm -B 127 -S 120 /dev/disk/by-id/ata-ST8000VN002-2ZM188_WPV35MJ5
  '';
}
