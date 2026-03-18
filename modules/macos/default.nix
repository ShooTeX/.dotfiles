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
    ./services

    ./system.nix
    ./homebrew.nix
  ];

  options.lab.macos = {
    enable = lib.mkEnableOption "Macos default config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    lab = {
      macosSystemConfig.enable = true;
      homebrew.enable = true;

      aerospace.enable = true;
      jankyborders.enable = true;
      netbird.enable = true;
    };
  };
}
