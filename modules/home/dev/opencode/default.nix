{ lib, config, ... }:
let
  cfg = config.lab.dev.opencode;
in
{

  options.lab.dev.opencode = {
    enable = lib.mkEnableOption "Opencode";
  };

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;

      enableMcpIntegration = true;

      tui = {
        theme = "kanagawa";
      };

      settings = {
        plugin = [ "opencode-anthropic-auth" ];
      };

      agents = {
        agent-creator = ./agents/agent-creator.md;
        brainstorm = ./agents/brainstorm.md;
        docs-writer = ./agents/docs-writer.md;
        eslint-expert = ./agents/eslint-expert.md;
        readme-writer = ./agents/readme-writer.md;
        security-auditor = ./agents/security-auditor.md;
      };
    };
  };
}
