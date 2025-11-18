{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opencode
    vectorcode
    github-mcp-server
  ];
}
