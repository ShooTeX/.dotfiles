{
  lib,
  stdenv,
  fetchurl,
}:

let
  version = "0.4.0";
  baseUrl = "https://github.com/braintrustdata/bt/releases/download/v${version}";

  targets = {
    "x86_64-linux" = {
      target = "x86_64-unknown-linux-musl";
      hash = lib.fakeHash;
    };
    "aarch64-linux" = {
      target = "aarch64-unknown-linux-musl";
      hash = lib.fakeHash;
    };
    "x86_64-darwin" = {
      target = "x86_64-apple-darwin";
      hash = lib.fakeHash;
    };
    "aarch64-darwin" = {
      target = "aarch64-apple-darwin";
      hash = "sha256-oVo4x81Nc8JLBD6O4yJUmS92m0ptnroa0vucY1cvp4s=";
    };
  };

  platform =
    targets.${stdenv.hostPlatform.system}
      or (throw "bt: unsupported platform ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "bt";
  inherit version;

  src = fetchurl {
    url = "${baseUrl}/bt-${platform.target}.tar.gz";
    inherit (platform) hash;
  };

  # musl binaries are statically linked — no autoPatchelf needed on Linux.
  # macOS binaries link against system libs so also don't need it.
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 bt $out/bin/bt
    runHook postInstall
  '';

  meta = {
    description = "Braintrust CLI — manage evals, prompts, and projects from the terminal";
    homepage = "https://bt.dev";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    mainProgram = "bt";
  };
}
