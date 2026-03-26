{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.lab.sops;
in
{
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        sops
      ]
      ++ lib.optional cfg.usingSecurityKey age-plugin-yubikey;
  };
}
