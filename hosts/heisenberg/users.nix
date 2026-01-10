{
  users.users.root.hashedPassword = "!";
  users.users.stx = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOC/I3GTOOTQFqLnFP8I5aTdfZoJB02C1phkTeetja1T"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  services.openssh.settings.PermitRootLogin = "no";
}
