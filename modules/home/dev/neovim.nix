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

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      withPython3 = false;
      withRuby = false;

      package = lib.mkDefault inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    xdg.configFile = {
      nvim = {
        source = lib.mkDefault inputs.nvim-config;
        recursive = true;
      };
    };
  };
}
