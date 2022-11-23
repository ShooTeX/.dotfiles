{ lib, stdenv, nvchad, ... }:
stdenv.mkDerivation {
	name = "nvchad-config";

	src = nvchad;

	patchPhase = ''
		echo 'hello' > testingtesting
		'';

	installPhase = ''
		cp -r . $out
		'';
}
