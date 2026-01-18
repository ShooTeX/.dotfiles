{ config, pkgs, ... }:
let
  logo = pkgs.writeText "logo.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 285 131">
      <path fill="#fbcfe8" fill-rule="evenodd" d="M0 20.3636V0h147.271v20.3636h-41.818v16h38.364v17.0926c-7.298-4.6628-15.969-7.3653-25.272-7.3653-15.84 0-29.8498 7.8361-38.3645 19.8433V20.3636H52.9091v72.7273H28V20.3636H0Zm176.111 72.7273h-10.566c0-7.6697-1.837-14.9103-5.095-21.3059l15.479-25.2395L148.293 0h28.363l15.273 27.0909h.727L208.111 0h28.182l-.001.00132c4.794-.01558 9.154.92488 12.779 2.52792 4.94 2.185 26.914 17.62496 31.238 21.94896 1.404 1.404 3.04 4.36 3.634 6.568 1.369 5.082-.898 11.695-5.644 16.467-2.678 2.693-3.992 3.25-7.671 3.25-3.767 0-4.613.38-5.58 2.502-.627 1.377-2.612 3.4-4.411 4.497-5.22 3.183-10.421 2.592-21.988-2.499-5.624-2.475-10.558-4.5-10.965-4.5-.67 0-3.817 9.219-3.817 11.182 0 .45 8.016.887 11.178.889 7.036.004 11.752 2.5611 13.81 7.4861 1.656 3.962 1.874 10.239.483 13.897-1.227 3.227-6.227 5.856-9.55 5.022-2.946-.74-6.493-4.86-6.493-7.544 0-.8338-1.61-1.3175-3.974-1.586l8.063 12.9816h-28.909l-15.819-27.6364h-.727l-15.818 27.6364Zm48.731-20.1929c6.716.0668 10.502.568 12.055 2.0273 1.262 1.186 2.584 3.473 2.937 5.084.939 4.275 2.914 2.875 3.258-2.31.465-7.022-6.998-8.322-20.075-8.936-.262-.0123-.517-.0243-.766-.0362l2.591 4.1709Zm-7.98-12.8487c.591-1.2278 1.184-2.9656 1.919-5.4661 3.03-10.307 3.79-11.82 5.939-11.82 1.043 0 7.109 2.237 13.481 4.971 15.102 6.48 15.67 6.6001 18.959 4.013 1.489-1.171 2.706-2.659 2.705-3.3069-.001-.647-6.188-4.3271-13.75-8.1771-12.101-6.161-13.07-11.9843-13.07-14.1723 0-1.517.644-2.611 1.653-2.805.32-.0614 1.433.9089 3.13 2.3871 3.135 2.7316 8.261 7.1973 14.042 10.0912 18.917 9.473 21.354 9.84 24.368 3.668 3.201-6.553 1.835-8.727-11.887-18.916-6.591-4.895-14.234-9.987-16.984-11.31696-3.536-1.709-6.61-2.39399-10.5-2.33999-1.791.02485-3.375.08766-4.791.19552L208.475 46.5455l8.387 13.5038Zm30.394-35.8561c-.996 2.595.399 4.739 2.857 4.39 1.652-.235 2.254-.987 2.254-2.82 0-1.833-.602-2.585-2.254-2.82-1.353-.192-2.496.308-2.857 1.25Z" clip-rule="evenodd"/>
      <circle cx="118.545" cy="93.0909" r="37" fill="#fbcfe8"/>
    </svg>
  '';

  package = pkgs.homepage-dashboard.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      mkdir -p $out/share/homepage/public/icons
      ln -s ${logo} $out/share/homepage/public/icons/logo.svg
    '';
  });
in
{
  sops.secrets.homepage = {
    format = "dotenv";
    sopsFile = ../secrets/homepage.enc.env;
    key = "";
  };

  services.homepage-dashboard = {
    inherit package;

    enable = true;
    environmentFile = config.sops.secrets.homepage.path;

    allowedHosts = "dottex.world";

    settings = {
      title = "DOTTEX World";
      favicon = "https://fav.farm/🦄";
      color = "pink";
      background = {
        image = "https://i.imgur.com/bsdz2KK.gif";
        blur = "sm";
        saturate = 50;
        brightness = 50;
        opacity = 50;
      };
    };

    widgets = [
      {
        logo = {
          icon = "/icons/logo.svg";
        };
      }
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "custom";
          url = "https://www.ecosia.org/search?q=";
          target = "_self";
          suggestionUrl = "https://ac.ecosia.org/autocomplete?type=list&q=";
          showSearchSuggestions = true;
        };
      }
    ];

    services = [
      {
        Services = [
          {
            Immich = {
              icon = "si-immich";
              description = "Photo/Video vault";
              href = "https://immich.dottex.world";
            };
          }
        ];
      }
      {
        Monitoring = [
          {
            Grafana = {
              icon = "si-grafana";
              description = "Monitoring Dashboards";
              href = "https://grafana.dottex.world";
            };
          }
          {
            "Uptime Kuma" = {
              description = "Service health monitoring tool";
              href = "http://uptime-kuma.dottex.world";
              icon = "si-uptimekuma";
              widgets = [
                {
                  type = "uptimekuma";
                  url = "https://uptime-kuma.dottex.world";
                  slug = "heisenberg";
                }
              ];
            };
          }
        ];
      }
    ];

    bookmarks = [
      {
        Entertainment = [
          {
            YouTube = [
              {
                icon = "si-youtube";
                href = "https://youtube.com/";
              }
            ];
          }
          {
            Twitch = [
              {
                icon = "si-twitch";
                href = "https://twitch.tv/";
              }
            ];
          }
        ];
      }
      {
        Hosting = [
          {
            Hetzner = [
              {
                icon = "si-hetzner";
                href = "https://console.hetzner.com/projects/1453084/dashboard";
              }
            ];
          }
        ];
      }
      {
        Nix = [
          {
            "NixOS Options" = [
              {
                icon = "si-nixos";
                href = "https://search.nixos.org/options";
              }
            ];
          }
        ];
      }
    ];
  };

  services.caddy.virtualHosts."dottex.world" = {
    useACMEHost = "dottex.world";
    extraConfig = ''
      reverse_proxy localhost:${toString config.services.homepage-dashboard.listenPort}
    '';
  };

}
