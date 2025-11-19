{ nvim-config, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile = {
    nvim = {
      source = nvim-config;
      recursive = true;
    };
  };
}
