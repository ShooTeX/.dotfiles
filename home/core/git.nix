{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    gitleaks
    mob
  ];

  programs.git = {
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

  programs.delta = {
    enable = true;
    options = {
      side-by-side = true;
      line-numbers = true;
    };
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };
}
