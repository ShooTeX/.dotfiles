{ config, lib, ... }:
let
  cfg = config.lab.jankyborders;
in
{
  options.lab.jankyborders = {
    enable = lib.mkEnableOption "Jankyborders";
  };

  config = lib.mkIf cfg.enable {
    services.jankyborders = {
      enable = true;
      active_color = "gradient(top_right=0xfffc5c7d,bottom_left=0xff6a82fb)";
      inactive_color = "0x00000000";
      width = 10.0;
    };
  };
}
