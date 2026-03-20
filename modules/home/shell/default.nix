{ config, lib, ... }:
let
  cfg = config.lab.shell;
in
{
  imports = [
    ./nushell.nix
    ./starship.nix
    ./zsh.nix
  ];

  options.lab.shell = {
    enable = lib.mkEnableOption "Enable shell";

    defaultShell = lib.mkOption {
      type = lib.types.enum [
        "nushell"
        "zsh"
      ];
      default = "nushell";
      description = "Select the default shell";
    };
  };

  config = {
    lab.shell = {
      starship.enable = true;

      nushell.enable = cfg.defaultShell == "nushell";
      zsh.enable = cfg.defaultShell == "zsh";
    };
  };
}
