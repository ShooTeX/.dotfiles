{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "aerospace";
  version = "0.14.2-Beta";

  src = pkgs.fetchurl {
    url = "https://github.com/nikitabobko/AeroSpace/releases/download/v${version}/AeroSpace-v${version}.zip";
    hash = "sha256-xOIP51kFQTy9RbCGQo5gJGMzl/WhZlJ+lCtMOaMCnB8=";
  };

  nativeBuildInputs = with pkgs; [
    installShellFiles
    unzip
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    OUT_APP="$out/Applications/AeroSpace.app"
    cp -r AeroSpace-v${version}/AeroSpace.app "$OUT_APP"

    install -D AeroSpace-v${version}/bin/aerospace $out/bin/aerospace
    installManPage AeroSpace-v${version}/manpage/*

    runHook postInstall
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/aerospace --version
  '';

  meta = with lib; {
    description = "AeroSpace is an i3-like tiling window manager for macOS";
    homepage = "https://github.com/nikitabobko/AeroSpace";
    license = licenses.mit;
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}
