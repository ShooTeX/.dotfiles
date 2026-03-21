{ config, lib, ... }:
let
  cfg = config.lab.dev;
in
{
  imports = [
    ./opencode

    ./neovim.nix
  ];

  options.lab.dev = {
    enable = lib.mkEnableOption "Enable default dev configurations";
  };

  config = lib.mkIf cfg.enable {
    lab.dev = {
      neovim.enable = true;
      opencode.enable = true;
    };
  };
}
