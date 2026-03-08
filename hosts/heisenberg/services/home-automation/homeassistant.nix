let
  dataDir = "/var/lib/homeassistant";
in
{
  virtualisation.oci-containers.containers.homeassistant = {
    image = "ghcr.io/home-assistant/home-assistant:2026.3.1";
    environment.TZ = "Europe/Berlin";
    volumes = [
      "${dataDir}:/config"
      "/run/dbus:/run/dbus:ro"
    ];
    extraOptions = [
      "--network=host"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/homeassistant 0755 root root -"
  ];

  services.caddy.virtualHosts."homeassistant.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:8123
    '';
  };

  services.restic.backups.storagebox.paths = [
    dataDir
  ];
}
