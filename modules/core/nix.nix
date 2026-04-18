{ config, lib, ... }:

let
  cfg = config.lab.nix;
in
{
  options.lab.nix = {
    enable = lib.mkEnableOption "Nix config";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      optimise.automatic = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        trusted-users = [
          "root"
          "@wheel"
          "stx"
        ];
      };
    };
  };
}
