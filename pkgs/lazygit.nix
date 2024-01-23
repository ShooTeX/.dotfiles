{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  lazygit = pkgs.stdenv.mkDerivation {
    name = "lazygit";
    src = fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "93fd429";
      sha256 = "sha256-sFPw8z0S7t70afExA7dAWyIkagNFOmHTTfCgrCfAO94="; # Replace with the actual sha256
    };
    buildInputs = [
      go
    ];
    buildPhase = ''
      export HOME=$(pwd)
      export GOCACHE=$TMPDIR/gocache
      go install
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp go/bin/lazygit $out/bin/
    '';
  };
in
lazygit
