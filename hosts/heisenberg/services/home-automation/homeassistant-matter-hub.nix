{ config, ... }:
let
  dataDir = "/var/lib/homeassistant-matter-hub";
in
{
  sops.secrets."homeassistant_matter_hub/env" = { };

  virtualisation.oci-containers.containers."homeassistant-matter-hub" = {
    image = "ghcr.io/t0bst4r/home-assistant-matter-hub:3.0.3";
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

  networking.firewall.allowedTCPPorts = [ 5540 ];
  networking.firewall.allowedUDPPorts = [ 5540 ];

  services.caddy.virtualHosts."matterhub.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:8482
    '';
  };

}
