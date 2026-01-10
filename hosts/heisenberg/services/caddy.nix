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

    # globalConfig = ''
    #   acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
    # '';

    extraConfig = ''
      (cf_dns) {
        tls {
          dns cloudflare {env.CF_API_KEY}
          resolvers 1.1.1.1
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
