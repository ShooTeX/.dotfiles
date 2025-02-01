{ stdenv, fetchFromGitHub, nodejs, pnpm_9 }:

stdenv.mkDerivation (finalAttrs: {
  pname = "hoarder";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "hoarder-app";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-3xgpiqq+BV0a/OlcQiGDt59fYNF+zP0+HPeBCRiZj48=";
  };

  nativeBuildInputs = [ nodejs pnpm_9.configHook ];

  pnpmWorkspaces = [ "@hoarderapp/cli" ];

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) pname version src pnpmWorkspaces;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm --filter=@hoarderapp/cli build

    runHook postBuild
  '';
})
