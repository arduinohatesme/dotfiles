{ config, pkgs, ... }:

let
  portfolioDomain = "arduinohates.me";
  forgeDomain = "git.arduinohates.me";
in
{
  users.users.nginx.extraGroups = [ "acme" ];
  networking.networkmanager.wifi.powersave = true;

  sleep.settings.Sleep = {
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspend = "no";
    AllowSuspendThenHibernate = "no";
  };

  logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;

      virtualHosts = {
        "${portfolioDomain}" = {
          enableACME = true;
          forceSSL = true;
          serverAliases = [ "www.${portfolioDomain}" ];
          root = "/var/www/${portfolioDomain}";

          locations."/" = {
            tryFiles = "$uri $uri/ =404";
          };
        };

        "${forgeDomain}" = {
          enableACME = true;
          forceSSL = true;

          extraConfig = ''
            client_max_body_size 512M;
          '';

          locations."/" = {
            proxyPass = "http://localhost:3000";
          };
        };
      };
    };

    forgejo = {
      enable = true;
      lfs.enable = true;
      database.type = "postgres";

      settings = {
        server = {
          DOMAIN = forgeDomain;
          ROOT_URL = "https://${forgeDomain}/";
          HTTP_PORT = 3000;
        };
        service.DISABLE_REGISTRATION = true;
      };
    };

    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances."${runnerName}" = {
        enable = true;
        name = runnerName;
        url = "http://localhost:3000";
        tokenFile = "/var/lib/forgejo-runner/runner-token";

        labels = [
          "native:host"
          "self-hosted:host"
        ];

        hostPackages = with pkgs; [
          nodejs_26
          pnpm
          uv
          python3
          gcc
          git
          coreutils
          bash
        ];
      };
    };
  };

  systemd.services."gitea-runner-${runnerName}" = {
    serviceConfig = {
      ReadWritePaths = [ "/var/www/${forgeDomain}" ];
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "awmcmillan128@gmail.com";
  };
}
