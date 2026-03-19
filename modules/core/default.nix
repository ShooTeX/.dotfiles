{ config, lib, ... }:
let
  cfg = config.lab.core;
in
{
  imports = [
    ./fonts.nix
    ./nix.nix
    ./sops.nix
  ];

  options.lab.core = {
    isHeadless = lib.mkEnableOption "headless mode (disables DE-specific config)";
  };

  config = {
    lab = {
      sops.enable = true;
      fonts.enable = !cfg.isHeadless;
      nix.enable = true;
    };
  };
}
