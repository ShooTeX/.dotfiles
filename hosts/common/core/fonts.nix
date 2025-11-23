{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    iosevka
    terminus_font_ttf
    nerd-fonts.symbols-only
  ];
}
