final: prev: {
  direnv = prev.direnv.overrideAttrs (old: {
    postPatch = ''
      substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
    '';
  });
}
