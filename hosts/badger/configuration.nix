{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ./users.nix
  ];

  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    steam-hardware.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  services = {
    xserver.videoDrivers = [ "nvidia" ];
    pipewire.enable = true;
    displayManager.ly.enable = true;
  };

  programs = {
    hyprland.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

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

  home-manager.users.stx.imports = [ ./home ];

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  networking.hostName = "badger";

  system.stateVersion = "24.05";

}
