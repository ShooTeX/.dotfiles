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
  config = lib.mkIf (cfg.enable && builtins.elem "go" cfg.active) {
    home.packages = with pkgs; [
      go
    ];

    home.sessionPath = [
      "$HOME/go/bin"
    ];
  };
}
