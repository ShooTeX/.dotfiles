{ pkgs, config, ... }:
{
  sops.secrets.caddy = {
    format = "dotenv";
    sopsFile = ../secrets/caddy.enc.env;
    key = "CLOUDFLARE_DNS_API_TOKEN";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@stx.wtf";

    certs =
      let
        domain = "dottex.world";
      in
      {
        "${domain}" = {
          inherit (config.services.caddy) group;

          reloadServices = [ "caddy.service" ];
          domain = "${domain}";
          extraDomainNames = [ "*.${domain}" ];
          # TODO: replace with hetzner dns
          dnsProvider = "cloudflare";
          dnsResolver = "1.1.1.1:53";
          dnsPropagationCheck = true;
          environmentFile = config.sops.secrets.caddy.path;
        };
      };

  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
    };

    globalConfig = ''
      acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
