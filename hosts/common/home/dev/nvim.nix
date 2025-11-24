{ inputs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    nvim = {
      source = inputs.nvim-config;
      recursive = true;
    };
  };
}
