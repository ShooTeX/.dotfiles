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
        keyFile = pkgs.writeText "sops-age-yubikey-identities" ''
          AGE-PLUGIN-YUBIKEY-18TMGYQVZSD0W33SXG6T7T
          AGE-PLUGIN-YUBIKEY-1MLP8SQVZSU9SEWSTDSSM4
        '';
        generateKey = false;
      };
      environment.PATH = lib.mkIf cfg.usingSecurityKey "${
        lib.makeBinPath [ pkgs.age-plugin-yubikey ]
      }:$PATH";

    };
  };
}
