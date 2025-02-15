{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;

let
  lazygit = pkgs.stdenv.mkDerivation {
    name = "lazygit";
    src = fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "93fd429";
      sha256 = "sha256-hcJJ2H4MvcszOjEyV834K0Uze9V9hwN9DOuetwaMS1A="; # Replace with the actual sha256
    };
    buildInputs = [ go ];
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
