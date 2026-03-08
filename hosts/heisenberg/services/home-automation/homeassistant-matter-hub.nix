{ config, ... }:
let
  dataDir = "/var/lib/homeassistant-matter-hub";
in
{
  sops.secrets."homeassistant_matter_hub/env" = { };

  virtualisation.oci-containers.containers."homeassistant-matter-hub" = {
    image = "ghcr.io/riddix/home-assistant-matter-hub:2.0.31";
    environment.TZ = "Europe/Berlin";
    volumes = [
      "${dataDir}:/data"
    ];
    extraOptions = [
      "--network=host"
    ];
    environment = {
      HAMH_HOME_ASSISTANT_URL = "https://homeassistant.dottex.world";
    };
    environmentFiles = [ config.sops.secrets."homeassistant_matter_hub/env".path ];
  };

  networking.firewall.allowedTCPPorts = [
    5353
    5540
    5541
  ];
  networking.firewall.allowedUDPPorts = [
    5353
    5540
    5541
  ];

  services.caddy.virtualHosts."matterhub.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:8482
    '';
  };

  services.restic.backups.storagebox.paths = [
    dataDir
  ];
}
