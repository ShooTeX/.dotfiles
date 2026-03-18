{
  config,
  lib,
  ...
}:

let
  cfg = config.lab.netbird;
in
{
  options.lab.netbird = {
    enable = lib.mkEnableOption "Default fonts";
  };

  config = lib.mkIf cfg.enable {
    services.netbird = {
      enable = true;
    };
  };
}
