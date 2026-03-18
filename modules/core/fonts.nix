{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.lab.fonts;
in
{
  options.lab.fonts = {
    enable = lib.mkEnableOption "Default fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      iosevka-comfy.comfy-fixed
      terminus_font_ttf
      nerd-fonts.symbols-only
    ];
  };
}
