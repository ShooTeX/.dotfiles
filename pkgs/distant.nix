{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  distant = pkgs.stdenv.mkDerivation {
    name = "distant";
    src = fetchFromGitHub {
      owner = "chipsenkbeil";
      repo = "distant";
      rev = "v0.20.0-alpha.12";
      sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with the actual sha256
    };
    buildPhase = ''
      cargo build --release --locked
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp target/release/distant $out/bin/
    '';
  };
in
distant
