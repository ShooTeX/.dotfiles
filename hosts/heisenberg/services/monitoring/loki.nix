{
  services.loki = {
    enable = false;
    configuration = {
      auth_enabled = false;
      server = {
        http_listen_port = 3100;
      };
    };
  };
}
