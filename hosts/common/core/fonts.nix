{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    iosevka
    iosevka-comfy.comfy-fixed
    terminus_font_ttf
    nerd-fonts.symbols-only
  ];
}
