{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vectorcode
    github-mcp-server
  ];

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    settings = {
      theme = "kanagawa";
    };
  };

  programs.mcp = {
    enable = true;

    servers = {
      shopifyDev = {
        command = "npx";
        "args" = [
          "-y"
          "@shopify/dev-mcp@latest"
        ];
      };
    };
  };
}
