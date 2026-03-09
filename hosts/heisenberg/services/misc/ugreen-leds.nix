{ pkgs, ... }:
{
  boot.kernelModules = [ "i2c-dev" ];

  users.groups.i2c = { };

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  users.users.ugreen-leds = {
    isSystemUser = true;
    group = "i2c";
  };

  systemd.services.ugreen-leds = {
    description = "UGREEN LEDs";
    wantedBy = [ "multi-user.target" ];
    # after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "ugreen-leds";
      Group = "i2c";
      ExecStart = pkgs.writeShellScript "ugreen-party.sh" ''
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli all -off -status
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli power  -color 255 0 255 -blink 400 600 
        sleep 0.1
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli netdev -color 255 0 0   -blink 400 600
        sleep 0.1
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli disk1  -color 255 255 0 -blink 400 600
        sleep 0.1
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli disk2  -color 0 255 0   -blink 400 600
        sleep 0.1
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli disk3  -color 0 255 255 -blink 400 600
        sleep 0.1
        ${pkgs.ugreen-leds-cli}/bin/ugreen_leds_cli disk4  -color 0 0 255   -blink 400 600
      '';
    };
  };
}
