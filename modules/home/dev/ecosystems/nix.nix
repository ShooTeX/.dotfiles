{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.lab.dev.ecosystems;
in
{
  config = lib.mkIf (cfg.enable && builtins.elem "nix" cfg.active) {
    home.packages = with pkgs; [
      nixd
      nixfmt
      statix
      deploy-rs
    ];
  };
}
