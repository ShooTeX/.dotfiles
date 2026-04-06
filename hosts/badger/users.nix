{ pkgs, ... }:
{
  users = {
    users = {
      root.hashedPassword = "!";
      stx = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "dottex"
        ];
        group = "stx";
      };
    };
    groups = {
      stx = { };
    };
  };

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;
  services.openssh.settings.PermitRootLogin = "no";
}
