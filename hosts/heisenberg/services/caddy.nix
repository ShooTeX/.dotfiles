{ pkgs, config, ... }:
{
  sops.secrets.caddy = {
    format = "dotenv";
    sopsFile = ../secrets/caddy.enc.env;
    key = "CF_API_KEY";
  };
  services.caddy = {
    enable = true;
    environmentFile = config.sops.secrets.caddy.path;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
    };

    globalConfig = ''
      acme_dns cloudflare {env.CF_API_KEY}
    '';
  };

  networking.firewall.allowedTCPPorts = [ 443 ];
}
