{ pkgs, config, ... }:
{
  sops.secrets.stx-password.neededForUsers = true;

  users = {
    users = {
      root.hashedPassword = "!";
      stx = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secerts.stx-password.path;
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
