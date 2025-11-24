{ inputs, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    package = inputs.neovim.packages.${pkgs.system}.default;
  };

  xdg.configFile = {
    nvim = {
      source = inputs.nvim-config;
      recursive = true;
    };
  };
}
