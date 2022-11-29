{ lib, stdenv, nvchad, nvim-config, ... }:
stdenv.mkDerivation rec {
  name = "nvchad-config";

  config = nvim-config;
  src = nvchad;
  patchPhase = ''
    cp -r $config lua/custom/ 
  '';

  installPhase = ''
    cp -r . $out
  '';
}
