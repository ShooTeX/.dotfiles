{ pkgs, ... }:
{
  users = {
    users = {
      root.hashedPassword = "!";
      stx = {
        isNormalUser = true;
        shell = pkgs.nushell;
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

  security.sudo.wheelNeedsPassword = false;
  services.openssh.settings.PermitRootLogin = "no";
}
