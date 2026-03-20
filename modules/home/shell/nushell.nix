{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.lab.shell.nushell;
in
{
  options.lab.shell.nushell = {
    enable = lib.mkEnableOption "Enable nushell";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableNushellIntegration = true;

    programs = {
      nushell = {
        enable = true;
        plugins = [
          pkgs.nushellPlugins.formats
        ];
      };

      zsh = {
        enable = lib.mkForce false;
      };

      carapace = {
        enable = true;
      };

    };
  };
}
