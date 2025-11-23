{ nvim-config, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    nvim = {
      source = nvim-config;
      recursive = true;
    };
  };
}
