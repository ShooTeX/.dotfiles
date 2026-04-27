{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.lab.cli-goodies;
in
{
  options.lab.cli-goodies = {
    enable = lib.mkEnableOption "Goodies like ripgrep, bottom, etc.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      bottom
      dust
      fd
      ffmpeg
      hyperfine
      jq
      pgcli
      ripgrep
      sd
      unzip
    ];

  };
}
