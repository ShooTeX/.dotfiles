{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  http4k = pkgs.stdenv.mkDerivation {
    name = "http4k";
    src = fetchurl {
      url =
        "https://github.com/http4k/toolbox-cli/releases/download/v5.0.0.0/http4k-toolbox-5.0.0.0.zip"; # Replace with the URL to the ZIP file in the release assets.
      sha256 =
        "VdK+NfwmIEw+aOtjGq5g3ZmA3x035FixqzT2SilS7xs="; # Replace with the actual SHA256 hash of the ZIP file.
    };

    nativeBuildInputs = [ pkgs.unzip ];
    buildInputs = [ pkgs.openjdk ];

    unpackPhase = ''
      mkdir -p $TMP/http4k-extracted
      unzip -q $src -d $TMP/http4k-extracted

      mkdir -p $TMP/http4k
      mv $TMP/http4k-extracted/*/* $TMP/http4k
    '';

    installPhase = ''
      mkdir -p $out/bin
      # Remove .bat files
      rm $TMP/http4k/bin/*.bat

      # Make the main executable executable
      chmod 0755 $TMP/http4k/bin/http4k

      # Install everything to the output path
      cp -r $TMP/http4k/* $out
    '';
  };
in http4k
