{
  config,
  lib,
  ...
}:

let
  cfg = config.lab.shell.starship;
in
{
  options.lab.shell.starship = {
    enable = lib.mkEnableOption "Enable starship prompt";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings = {
        character = {
          error_symbol = "[❯](red)";
          success_symbol = "[❯](purple)";
          vimcmd_symbol = "[❮](green)";
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };
        directory = {
          style = "blue";
        };
        format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };
        git_state = {
          format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          style = "bright-black";
        };
        git_status = {
          conflicted = "​";
          deleted = "​";
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          modified = "​";
          renamed = "​";
          staged = "​";
          stashed = "≡";
          style = "cyan";
          untracked = "​";
        };
      };
    };
  };
}
