{
  config,
  lib,
  ...
}:
let
  cfg = config.lab.macos;
in
{
  imports = [
    ./aerospace.nix
    ./jankyborders.nix
    ./netbird.nix
  ];

  options.lab.macos = {
    enable = lib.mkEnableOption "Macos default config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    lab = {
      aerospace.enable = true;
      jankyborders.enable = true;
      netbird.enable = true;
    };
  };
}
