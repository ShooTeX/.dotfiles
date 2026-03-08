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
      homeassistant.enabled = true;
      permit_join = false;
      serial = {
        port = "/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0";
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
      devices = {
        "0x001788010d21f603".friendly_name = "Kitchen Ceiling";
        "0x001788010bab7ebb".friendly_name = "Livingroom Ceiling";
        "0x001788010c930a58".friendly_name = "Bathroom Ceiling 1";
        "0x001788010c9b303c".friendly_name = "Bathroom Ceiling 2";
        "0x001788010e7c361a".friendly_name = "Office Ceiling";
        "0x001788010d961c0e".friendly_name = "Kitchen Ceiling Spot 2";
        "0x001788010d548335".friendly_name = "Kitchen Ceiling Spot 3";
        "0x001788010c977a1d".friendly_name = "Hallway Ceiling 3";
        "0x001788010c903720".friendly_name = "Hallway Ceiling 2";
        "0x001788010c9a2207".friendly_name = "Hallway Ceiling 4";
        "0x001788010c9a17de".friendly_name = "Hallway Ceiling 1";
        "0x001788010d963bf8".friendly_name = "Kitchen Ceiling Spot 1";
        "0x001788010ba5cbfd".friendly_name = "Bedroom Ceiling";
        "0x001788010d545ff9".friendly_name = "Kitchen Ceiling Spot 4";
        "0x001788010e6adad7".friendly_name = "Livingroom Sofa 1";
        "0x001788010dd964cc".friendly_name = "Livingroom Sofa 2";
        "0xa4c1385c284a4326".friendly_name = "Smart Plug 1";
        "0xa4c13885f9360b97".friendly_name = "Outdoor Smart Plug 1";
        "0x001788010f2ab6e2".friendly_name = "Livingroom Donut 1";
        "0x001788010f2ab833".friendly_name = "Livingroom Donut 2";
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
