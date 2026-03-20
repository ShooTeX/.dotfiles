{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.lab.git;
in
{

  options.lab.git = {
    enable = lib.mkEnableOption "Enable git config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gitleaks
      mob
      git-crypt
    ];

    programs = {
      git = {
        enable = true;

        settings = {
          user = {
            name = "Erik Simon";
            email = "10850738+ShooTeX@users.noreply.github.com";
          };
          push = {
            autoSetupRemote = true;
          };
          pull = {
            ff = "only";
          };
          merge = {
            ff = "only";
          };
          fetch = {
            prune = true;
          };
          init = {
            defaultBranch = "main";
          };
          help = {
            autocorrect = "prompt";
          };
          rerere = {
            enabled = true;
          };
        };
      };

      delta = {
        enable = true;
        options = {
          side-by-side = true;
          line-numbers = true;
        };
        enableGitIntegration = true;
      };

      lazygit = {
        enable = true;
      };

      gh = {
        enable = true;
      };
    };
  };
}
