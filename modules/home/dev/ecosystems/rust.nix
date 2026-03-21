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
  config = lib.mkIf (cfg.enable && builtins.elem "rust" cfg.active) {
    home.packages = with pkgs; [
      rustup
    ];

    home.sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };
}
