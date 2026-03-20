{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.lab.dev.neovim;
in
{
  options.lab.dev.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      package = lib.mkDefault inputs.neovim.packages.${pkgs.system}.default;
    };

    xdg.configFile = {
      nvim = {
        source = lib.mkDefault inputs.nvim-config;
        recursive = true;
      };
    };
  };
}
