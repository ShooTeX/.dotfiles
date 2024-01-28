{
  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };

    extraConfig = {
      user = {
        name = "Erik Simon";
        email = "10850738+ShooTeX@users.noreply.github.com";
      };
      push = { autoSetupRemote = true; };
      pull = { ff = "only"; };
      merge = { ff = "only"; };
      fetch = { prune = true; };
      init = { defaultBranch = "main"; };
    };
  };
}
