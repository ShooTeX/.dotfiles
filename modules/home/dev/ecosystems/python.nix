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
  config = lib.mkIf (cfg.enable && builtins.elem "python" cfg.active) {
    home.packages = with pkgs; [
      pipx
    ];
  };
}
