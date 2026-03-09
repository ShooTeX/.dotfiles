{ config, ... }:
{
  sops.secrets = {
    "authelia_user_database.yaml" = {
      sopsFile = "../../secrets/authelia_user_database.enc.yaml";
      key = "";
    };
    "authelia/jwt_secret" = { };
    "authelia/oidc_hmac_secret" = { };
    "authelia/oidc_jwks_key" = { };
    "authelia/session_secret" = { };
    "authelia/storage_encryption_key" = { };
  };
  services.authelia.instances.main = {
    enable = true;

    settings = {
      theme = "auto";

      authentication_backend.file = {
        inherit (config.sops.secrets."authelia_user_database.yaml") path;
        watch = true;
      };

    };

    secrets = {
      jwtSecretFile = config.sops.secrets."authelia/jwt_secret";
      oidcHmacSecretFile = config.sops.secrets."authelia/oidc_hmac_secret";
      oidcIssuerPrivateKeyFile = config.sops.secrets."authelia/oidc_jwks_key";
      sessionSecretFile = config.sops.secrets."authelia/session_secret";
      storageEncryptionKeyFile = config.sops.secrets."authelia/storage_encryption_key";
    };
  };
}
