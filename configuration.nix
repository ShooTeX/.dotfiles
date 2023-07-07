{ pkgs, lib, ... }: {
  nix.extraOptions =
    "	auto-optimise-store = true\n	experimental-features = nix-command flakes\n"
    + lib.optionalString (pkgs.system == "aarch64-darwin")
    "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;
  services.nix-daemon.enable = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [ iosevka (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
