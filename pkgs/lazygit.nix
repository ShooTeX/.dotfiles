{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  lazygit = pkgs.stdenv.mkDerivation {
    name = "lazygit";
    src = fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "1d1b8cc";
      sha256 = "sha256-Qt50tBA7zAHoHv/GzpTcwpkJvq3TO96D8ClAw2TaABI="; # Replace with the actual sha256
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
