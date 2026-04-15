{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.lab.misc;
in
{
  options.lab.misc = {
    enable = lib.mkEnableOption "Misc stuff like ausweisapp";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.optionals (!pkgs.stdenv.isDarwin) [ ausweisapp ];
  };
}
