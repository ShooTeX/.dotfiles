{ pkgs, lib, ... }:

{
  ids.gids.nixbld = 30000;
  nix.optimise.automatic = true;
  nix.extraOptions =
    "	experimental-features = nix-command flakes\n"
    + lib.optionalString (
      pkgs.system == "aarch64-darwin"
    ) "	extra-platforms = x86_64-darwin aarch64-darwin\n";

  programs.zsh.enable = true;
}
