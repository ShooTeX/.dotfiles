{
  services = {
    uptime-kuma = {
      enable = false;
      settings = {
        PORT = "4251";
      };
    };

    # borgmatic.settings = {
    #   source_directories = [
    #     "/var/lib/private/uptime-kuma"
    #   ];
    # };
    #
    # caddy.virtualHosts."uptime-kuma.dottex.world" = {
    #   useACMEHost = "dottex.world";
    #   extraConfig = ''
    #     reverse_proxy localhost:${toString config.services.uptime-kuma.settings.PORT}
    #   '';
    # };
  };
}
