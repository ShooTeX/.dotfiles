{ pkgs, lib, ... }:
{
	nix.extraOptions = ''
		auto-optimise-store = true
		experimental-features = nix-command flakes
	'' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
		extra-platforms = x86_64-darwin aarch64-darwin
	'';

	programs.zsh.enable = true;
	services.nix-daemon.enable = true;

	fonts.fontDir.enable = true;
	fonts.fonts = with pkgs; [
		recursive
		(nerdfonts.override { fonts = [ "Iosevka" ]; })
	];

	system.keyboard = {
		enableKeyMapping = true;
		remapCapsLockToEscape = true;
	};

	homebrew = {
		enable = true;
		onActivation.autoUpdate = true;
		casks = [
			"alfred"
			"google-chrome"
		];
	};

	security.pam.enableSudoTouchIdAuth = true;
}
