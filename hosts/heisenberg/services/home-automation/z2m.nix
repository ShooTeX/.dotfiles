{ config, ... }:
{
  sops.secrets."z2m.yaml" = {
    sopsFile = ../../secrets/z2m.enc.yaml;
    owner = "zigbee2mqtt";
    group = "zigbee2mqtt";
    key = "";
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      homeassistant.enable = true;
      permit_join = false;
      serial = {
        port = "/dev/ttyUSB0";
        adapter = "zstack";
      };
      mqtt.server = "mqtt://localhost:${toString (builtins.head config.services.mosquitto.listeners).port}";
      frontend.port = 8080;
      advanced = {
        channel = 20;
        network_key = "!${config.sops.secrets."z2m.yaml".path} network_key";
        pan_id = 58248;
        ext_pan_id = [
          202
          168
          172
          204
          177
          16
          106
          237
        ];
      };
    };
  };

  services.caddy.virtualHosts."z2m.dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:${toString config.services.zigbee2mqtt.settings.frontend.port}
    '';
  };
}
