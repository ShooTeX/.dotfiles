{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-mcp-server
  ];

  programs.opencode = {
    enable = true;

    enableMcpIntegration = true;

    settings = {
      theme = "kanagawa";
    };

    agents = {
      docs-writer = ./agents/docs-writer.md;
      security-auditor = ./agents/security-auditor.md;
    };
  };

  programs.mcp = {
    enable = true;

    # servers = {
    #   shopifyDev = {
    #     enable = false;
    #     command = "npx";
    #     args = [
    #       "-y"
    #       "@shopify/dev-mcp@latest"
    #     ];
    #   };
    #   asana = {
    #     enable = false;
    #     command = "npx";
    #     args = [
    #       "-y"
    #       "mcp-remote"
    #       "https://mcp.asana.com/sse"
    #     ];
    #   };
    # };
  };
}
