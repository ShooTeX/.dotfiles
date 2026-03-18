{ config, lib, ... }:
let
  cfg = config.lab.homebrew;
in
{
  options.lab.homebrew = {
    enable = lib.mkEnableOption "Homebrew";

    withDefaultCasks = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
      casks = lib.optionals cfg.withDefaultCasks [
        "1password"
        "orbstack"
        "raycast"
        "whatsapp"
        "yubico-authenticator"
        "ghostty"
      ];
    };
  };
}
