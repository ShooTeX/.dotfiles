(final: prev: {
  prometheus-restic-exporter = prev.prometheus-restic-exporter.overrideAttrs (old: {
    version = "2.0.2";
    src = prev.fetchFromGitHub {
      owner = "ngosang";
      repo = "restic-exporter";
      rev = "2.0.2";
      hash = "sha256-F0lNjAjtcOihSIJLux6Gyig7UU9Tl+PcZ0xQ/KryCpQ=";
    };
    installPhase = ''
      runHook preInstall

      install -D -m0755 exporter/exporter.py $out/bin/restic-exporter.py

      substituteInPlace $out/bin/restic-exporter.py --replace-fail \"restic\" \"${
        prev.lib.makeBinPath [ final.restic ]
      }/restic\"

      patchShebangs $out/bin/restic-exporter.py

      runHook postInstall
    '';
  });
})
