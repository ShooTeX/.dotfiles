{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.lab.terminal;
in
{
  options.lab.terminal = {
    enable = lib.mkEnableOption "enable terminal";

    default = lib.mkOption {
      type = lib.types.enum [
        "ghostty"
      ];
      default = "ghostty";
      description = "Select the default terminal";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.default == "ghostty") {
    home.sessionVariables = {
      TERMINAL = "ghostty";
    };

    programs.ghostty = {
      enable = true;

      package = lib.mkIf pkgs.stdenv.isDarwin null; # Currently broken on macos, installed via homebrew

      installVimSyntax = lib.mkIf (!pkgs.stdenv.isDarwin) true;
      systemd.enable = lib.mkIf (!pkgs.stdenv.isDarwin) true;

      settings = {
        command = lib.mkIf (
          config.lab.shell.defaultShell == "nushell" && pkgs.stdenv.isDarwin
        ) "${pkgs.nushell}/bin/nu";
        theme = lib.mkDefault "Kanagawa Dragon";

        font-family = lib.mkDefault "Iosevka Comfy Fixed";
        font-size = lib.mkDefault 16;
        font-thicken = lib.mkIf pkgs.stdenv.isDarwin true;

        macos-titlebar-style = lib.mkDefault "hidden";

        quit-after-last-window-closed = lib.mkDefault true;
        macos-option-as-alt = lib.mkDefault true;

        cursor-style = lib.mkDefault "block";
        shell-integration-features = lib.mkDefault "no-cursor";
      };
    };
  };
}
