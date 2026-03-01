{ pkgs, ... }:
{
  users = {
    users = {
      root.hashedPassword = "!";
      stx = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "dottex"
        ];
        group = "stx";
        openssh = {
          authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOC/I3GTOOTQFqLnFP8I5aTdfZoJB02C1phkTeetja1T"
          ];
        };
      };
      punkt = {
        isSystemUser = true;
        shell = pkgs.shadow;
        group = "punkt";
        extraGroups = [ "dottex" ];
      };
    };
    groups = {
      stx = { };
      punkt = { };
      dottex = { };
      stxShared = { };
    };
  };

  security.sudo.wheelNeedsPassword = false;
  services.openssh.settings.PermitRootLogin = "no";
}
