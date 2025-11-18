{
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    # installVimSyntax = true;
    # systemd = {
    #   enable = true;
    # };

    package = null;

    settings = {
      theme = "Carbonfox";
      font-family = "Iosevka";
      font-size = 18;

      macos-titlebar-style = "hidden";

      quit-after-last-window-closed = true;

      cursor-style = "block";
    };
  };
}
