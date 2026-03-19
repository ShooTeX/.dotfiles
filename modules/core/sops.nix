{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.lab.sops;
in
{
  options.lab.sops = {
    enable = lib.mkEnableOption "SOPS";

    usingSecurityKey = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether a YubiKey is used for age decryption";
    };

    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;

      age = lib.mkIf cfg.usingSecurityKey {
        keyFile = "/etc/sops-nix-key";
        generateKey = false;
        plugins = [ pkgs.age-plugin-yubikey ];
      };
    };
    environment = {
      etc."sops-nix-key" = {
        enable = cfg.usingSecurityKey;
        text = ''
          AGE-PLUGIN-YUBIKEY-18TMGYQVZSD0W33SXG6T7T
          AGE-PLUGIN-YUBIKEY-1MLP8SQVZSU9SEWSTDSSM4
        '';
      };
      variables = {
        SOPS_AGE_KEY_FILE = lib.mkIf cfg.usingSecurityKey "/etc/sops-nix-key";
      };
    };
  };
}
