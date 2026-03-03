# NixOS Module: Fluxer
#
# A free and open source instant messaging and VoIP platform (Discord alternative).
# https://github.com/fluxerapp/fluxer
#
# NOTE: Fluxer is currently in active development and undergoing a major refactor.
# This module targets the post-refactor self-hosting stack described by the developer:
#   - fluxer-server  (TypeScript/Node.js, SQLite by default)
#   - fluxer-gateway (Erlang/OTP, real-time messaging)
#   - LiveKit        (WebRTC SFU for voice/video)
#
# Until an official Nix package exists, build the server and gateway yourself and
# point `package` / `gatewayPackage` at the resulting derivations, or use
# `pkgs.callPackage ./fluxer-server.nix {}` etc.
#
# Usage in your NixOS flake:
#
#   services.fluxer = {
#     enable = true;
#     domain = "chat.example.com";
#     secretKeyFile = config.age.secrets.fluxer-secret-key.path;
#     livekit.secretFile = config.age.secrets.livekit-secret.path;
#   };

{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.fluxer;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    mkMerge
    types
    literalExpression
    optionalString
    optionalAttrs
    ;
in
{
  ##############################################################################
  # Options
  ##############################################################################

  options.services.fluxer = {

    enable = mkEnableOption "Fluxer — open-source Discord alternative";

    # ── Packages ──────────────────────────────────────────────────────────────

    package = mkOption {
      type = types.package;
      # Replace with the real derivation once a Nix package is available.
      default = pkgs.runCommand "fluxer-server-placeholder" { } ''
        echo "Build fluxer-server from source or override this option" >&2; exit 1
      '';
      defaultText = literalExpression "pkgs.fluxer-server";
      description = ''
        The fluxer-server package. Override with your own derivation until an
        official Nixpkgs package is available.
      '';
    };

    gatewayPackage = mkOption {
      type = types.package;
      default = pkgs.runCommand "fluxer-gateway-placeholder" { } ''
        echo "Build fluxer-gateway from source or override this option" >&2; exit 1
      '';
      defaultText = literalExpression "pkgs.fluxer-gateway";
      description = ''
        The fluxer-gateway (Erlang) package. Override with your own derivation.
      '';
    };

    # ── Core settings ─────────────────────────────────────────────────────────

    domain = mkOption {
      type = types.str;
      example = "chat.example.com";
      description = "Public domain name of the Fluxer instance.";
    };

    port = mkOption {
      type = types.port;
      default = 4000;
      description = "Port the Fluxer HTTP server listens on (internal).";
    };

    gatewayPort = mkOption {
      type = types.port;
      default = 4001;
      description = "Port the Fluxer WebSocket gateway listens on (internal).";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/fluxer";
      description = "Directory for Fluxer data (SQLite database, uploads, etc.).";
    };

    secretKeyFile = mkOption {
      type = types.path;
      example = "/run/secrets/fluxer-secret-key";
      description = ''
        Path to a file containing the application secret key (used for signing
        sessions and tokens). Generate with: openssl rand -hex 64
      '';
    };

    # ── Database ──────────────────────────────────────────────────────────────

    database = {
      type = mkOption {
        type = types.enum [
          "sqlite"
          "postgres"
        ];
        default = "sqlite";
        description = "Database backend to use.";
      };

      sqlitePath = mkOption {
        type = types.str;
        default = "\${cfg.dataDir}/fluxer.db";
        defaultText = literalExpression ''"''${config.services.fluxer.dataDir}/fluxer.db"'';
        description = "Path to the SQLite database file (only used when type = sqlite).";
      };

      # PostgreSQL options (used when type = "postgres")
      host = mkOption {
        type = types.str;
        default = "localhost";
        description = "PostgreSQL host (only used when type = postgres).";
      };

      port = mkOption {
        type = types.port;
        default = 5432;
        description = "PostgreSQL port.";
      };

      name = mkOption {
        type = types.str;
        default = "fluxer";
        description = "PostgreSQL database name.";
      };

      user = mkOption {
        type = types.str;
        default = "fluxer";
        description = "PostgreSQL user.";
      };

      passwordFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/run/secrets/fluxer-db-password";
        description = "File containing the PostgreSQL password. Leave null for peer auth.";
      };
    };

    # ── Email ─────────────────────────────────────────────────────────────────

    smtp = {
      host = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = "smtp.example.com";
        description = "SMTP host for sending email (verification codes, notifications).";
      };

      port = mkOption {
        type = types.port;
        default = 587;
        description = "SMTP port.";
      };

      user = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SMTP username.";
      };

      passwordFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "File containing the SMTP password.";
      };

      from = mkOption {
        type = types.str;
        default = "noreply@${cfg.domain}";
        defaultText = literalExpression ''"noreply@''${config.services.fluxer.domain}"'';
        description = "From address for outgoing mail.";
      };
    };

    # ── LiveKit (voice & video) ───────────────────────────────────────────────

    livekit = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable LiveKit for voice and video calls.";
      };

      url = mkOption {
        type = types.str;
        default = "http://localhost:7880";
        description = "Internal URL of the LiveKit server.";
      };

      apiKey = mkOption {
        type = types.str;
        default = "fluxer";
        description = "LiveKit API key.";
      };

      secretFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/run/secrets/livekit-secret";
        description = "File containing the LiveKit API secret.";
      };
    };

    # ── Reverse proxy ─────────────────────────────────────────────────────────

    nginx = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Configure nginx as a reverse proxy for Fluxer.";
      };

      useACME = mkOption {
        type = types.bool;
        default = true;
        description = "Use ACME (Let's Encrypt) to obtain a TLS certificate.";
      };
    };

    caddy = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Configure Caddy as a reverse proxy for Fluxer (auto-HTTPS).";
      };
    };

    # ── Extra environment ─────────────────────────────────────────────────────

    extraEnvironment = mkOption {
      type = types.attrsOf types.str;
      default = { };
      example = literalExpression ''
        {
          LOG_LEVEL = "info";
          MAX_FILE_SIZE_MB = "50";
        }
      '';
      description = "Extra environment variables passed to the Fluxer server.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open firewall ports for Fluxer (HTTP port only; keep gateway internal).";
    };
  };

  ##############################################################################
  # Implementation
  ##############################################################################

  config = mkIf cfg.enable {

    # ── System user & group ───────────────────────────────────────────────────

    users.users.fluxer = {
      isSystemUser = true;
      group = "fluxer";
      home = cfg.dataDir;
      createHome = true;
      description = "Fluxer service user";
    };

    users.groups.fluxer = { };

    # ── PostgreSQL (optional) ─────────────────────────────────────────────────

    services.postgresql = mkIf (cfg.database.type == "postgres") {
      enable = true;
      ensureDatabases = [ cfg.database.name ];
      ensureUsers = [
        {
          name = cfg.database.user;
          ensureDBOwnership = true;
        }
      ];
    };

    # ── LiveKit (optional) ────────────────────────────────────────────────────

    services.livekit = mkIf cfg.livekit.enable {
      enable = true;
      # Adjust to match your livekit NixOS module options if using one,
      # or manage livekit as a separate systemd service below.
    };

    # ── Systemd: fluxer-server ────────────────────────────────────────────────

    systemd.services.fluxer-server = {
      description = "Fluxer Server (TypeScript/Node.js)";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
      ]
      ++ lib.optional (cfg.database.type == "postgres") "postgresql.service"
      ++ lib.optional cfg.livekit.enable "livekit.service";

      serviceConfig = {
        Type = "simple";
        User = "fluxer";
        Group = "fluxer";
        WorkingDirectory = cfg.dataDir;
        Restart = "on-failure";
        RestartSec = "5s";

        # Load the secret key and (optionally) db/smtp/livekit secrets at runtime
        EnvironmentFile = [
          cfg.secretKeyFile
        ]
        ++ lib.optional (cfg.database.passwordFile != null) cfg.database.passwordFile
        ++ lib.optional (cfg.smtp.passwordFile != null) cfg.smtp.passwordFile
        ++ lib.optional (cfg.livekit.secretFile != null) cfg.livekit.secretFile;

        # Hardening
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ cfg.dataDir ];
        CapabilityBoundingSet = "";
        LockPersonality = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        SystemCallFilter = "@system-service";
      };

      environment = mkMerge [
        {
          NODE_ENV = "production";
          HOST = "127.0.0.1";
          PORT = toString cfg.port;
          PUBLIC_URL = "https://${cfg.domain}";
          GATEWAY_URL = "http://127.0.0.1:${toString cfg.gatewayPort}";

          # Database
          DB_TYPE = cfg.database.type;
          SQLITE_PATH = cfg.database.sqlitePath;
          DB_HOST = cfg.database.host;
          DB_PORT = toString cfg.database.port;
          DB_NAME = cfg.database.name;
          DB_USER = cfg.database.user;

          # SMTP
          SMTP_HOST = lib.optionalString (cfg.smtp.host != null) cfg.smtp.host;
          SMTP_PORT = toString cfg.smtp.port;
          SMTP_USER = lib.optionalString (cfg.smtp.user != null) cfg.smtp.user;
          SMTP_FROM = cfg.smtp.from;

          # LiveKit
          LIVEKIT_URL = cfg.livekit.url;
          LIVEKIT_API_KEY = cfg.livekit.apiKey;
        }
        cfg.extraEnvironment
      ];

      script = ''
        # SECRET_KEY is expected to be exported via EnvironmentFile
        exec ${cfg.package}/bin/fluxer-server
      '';
    };

    # ── Systemd: fluxer-gateway ───────────────────────────────────────────────

    systemd.services.fluxer-gateway = {
      description = "Fluxer Gateway (Erlang/OTP real-time messaging)";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
        "fluxer-server.service"
      ];
      bindsTo = [ "fluxer-server.service" ];

      serviceConfig = {
        Type = "simple";
        User = "fluxer";
        Group = "fluxer";
        WorkingDirectory = cfg.dataDir;
        Restart = "on-failure";
        RestartSec = "5s";

        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ cfg.dataDir ];

        # Erlang needs these for distributed operation
        LimitNOFILE = 65536;
      };

      environment = {
        GATEWAY_PORT = toString cfg.gatewayPort;
        SERVER_URL = "http://127.0.0.1:${toString cfg.port}";
      };

      script = ''
        exec ${cfg.gatewayPackage}/bin/fluxer-gateway
      '';
    };

    # ── nginx reverse proxy ───────────────────────────────────────────────────

    services.nginx = mkIf cfg.nginx.enable {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;

      virtualHosts."${cfg.domain}" = {
        forceSSL = cfg.nginx.useACME;
        enableACME = cfg.nginx.useACME;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString cfg.port}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_read_timeout 3600;
            proxy_send_timeout 3600;
            client_max_body_size 100M;
          '';
        };

        # WebSocket gateway endpoint
        locations."/gateway" = {
          proxyPass = "http://127.0.0.1:${toString cfg.gatewayPort}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_read_timeout 3600;
            proxy_send_timeout 3600;
          '';
        };
      };
    };

    # ACME (if nginx is the proxy and ACME is requested)
    security.acme = mkIf (cfg.nginx.enable && cfg.nginx.useACME) {
      acceptTerms = true;
      # Set security.acme.defaults.email in your host config
    };

    # ── Caddy reverse proxy ───────────────────────────────────────────────────

    services.caddy = mkIf cfg.caddy.enable {
      enable = true;
      virtualHosts."${cfg.domain}".extraConfig = ''
        encode gzip

        # Main app
        reverse_proxy /gateway* localhost:${toString cfg.gatewayPort} {
          transport http {
            keepalive 1h
          }
        }

        reverse_proxy * localhost:${toString cfg.port} {
          header_up X-Real-IP {remote_host}
          header_up X-Forwarded-For {remote_host}
        }

        request_body {
          max_size 100MB
        }
      '';
    };

    # ── Firewall ──────────────────────────────────────────────────────────────

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      80
      443
    ];

    # ── Assertions ────────────────────────────────────────────────────────────

    assertions = [
      {
        assertion = !(cfg.nginx.enable && cfg.caddy.enable);
        message = "services.fluxer: cannot enable both nginx and caddy reverse proxies simultaneously.";
      }
      {
        assertion = cfg.database.type == "postgres" -> cfg.database.host != "";
        message = "services.fluxer: database.host must be set when using postgres.";
      }
      {
        assertion = cfg.livekit.enable -> cfg.livekit.secretFile != null;
        message = "services.fluxer: livekit.secretFile must be set when livekit.enable = true.";
      }
    ];
  };
}
