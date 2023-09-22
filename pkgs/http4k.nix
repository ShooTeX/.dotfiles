{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  http4k = pkgs.stdenv.mkDerivation {
    name = "http4k";
    src = fetchFromGitHub {
      owner = "http4k";
      repo = "toolbox-cli";
      rev = "v5.0.0.0";
      sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with the actual sha256
    };

    nativeBuildInputs = [ pkgs.unzip ];
    buildInputs = [ pkgs.openjdk ];

    installPhase = ''
            # Remove .bat files
            rm $out/bin/*.bat

            # Make the main executable executable
            chmod 0755 $out/bin/http4k

            # Install everything to the output path
            cp -r $src/* $out/

            # Create a wrapper script
            mkdir -p $out/bin
            cat > $out/bin/http4k <<EOF
      #!/bin/sh
      exec $out/bin/http4k-toolbox "\$@"
      EOF
            chmod +x $out/bin/http4k
    '';
  };
in
http4k
