{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  distant = pkgs.stdenv.mkDerivation {
    name = "distant";
    src = fetchFromGitHub {
      owner = "chipsenkbeil";
      repo = "distant";
      rev = "v0.20.0-alpha.12";
      sha256 = "jOK1v0sGPeoVoSbl1NjuSJjAfskVuX5X152f07WQkVY="; # Replace with the actual sha256
    };
    buildInputs = [
      cargo
      perl
      darwin.apple_sdk.frameworks.SystemConfiguration
      coreutils
    ];
    buildPhase = ''
      export CARGO_HOME=$TMPDIR/cargo
      export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
      RUST_BACKTRACE=full cargo build --release --locked
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp target/release/distant $out/bin/
    '';
    nativeBuildInputs = [
      cacert
    ];
  };
in
distant
