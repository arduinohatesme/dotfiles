{ config, pkgs, ... }:

let
  portfolioDomain = "arduinohates.me";
  forgeDomain = "git.arduinohates.me";
  runnerName = "thirtyoneiron";
in
{
  users.users.nginx.extraGroups = [ "acme" ];
  networking.networkmanager.wifi.powersave = true;

  systemd.sleep.settings.Sleep = {
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspend = "no";
    AllowSuspendThenHibernate = "no";
  };

  services.logind.settings.Login = {
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

      commonHttpConfig = ''
        map $http_origin $cors_origin {
            default "";
            "https://arduinohates.me" "$http_origin";
            "http://localhost:5173" "$http_origin";
          }
      '';

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
            add_header Access-Control-Allow-Origin $cors_origin always;
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

        cors = {
          ENABLED = true;
          ALLOW_DOMAIN = "arduinohates.me, localhost:5173";
          SCHEME = "*";
        };

        service.DISABLE_REGISTRATION = true;
      };
    };

    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances."${runnerName}" = {
        enable = true;
        name = runnerName;
        url = "https://${forgeDomain}";
        tokenFile = "/var/lib/forgejo-runner/runner-token";

        labels = [
          "ThirtyOneIron:host"
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];

        hostPackages = with pkgs; [
          nodejs_26
          pnpm
          uv
          python3
          gcc
          git
          coreutils
          gnutar
          gzip
          curl
          wget
          xz
          bash
          rsync
        ];
      };
    };
  };

  systemd.services = {
    "gitea-runner-${runnerName}" = {
      serviceConfig = {
        PrivateNetwork = false;
        Environment = [ "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt" ];
        ReadWritePaths = [
          "-/var/www/${forgeDomain}"
          "-/var/lib/gitea-runner"
          "-/tmp"
        ];
      };
    };

    rebuild-system = {
      description = "Rebuild-switch the system";
      path = with pkgs; [
        nix
        nixos-rebuild
        git
        systemd
      ];

      environment = {
        SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      };

      serviceConfig = {
        Type = "oneshot";
        User = "root";
        ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /home/amcmillan/.config#thirtyoneiron";
        Restart = "no";
      };
    };
  };

  security = {
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id !== "org.freedesktop.systemd1.manage-units") return;

        var unit = action.lookup("unit");
        var verb = action.lookup("verb");
        if (unit !== "rebuild-system.service") return;
        if (verb !== "start") return;

        if (subject.user === "gitea-runner") return "yes";
        if (
          subject.uid >= 61184 &&
          subject.uid <= 65519
        ) {
          return "yes";
        }
      });
    '';

    acme = {
      acceptTerms = true;
      defaults.email = "awmcmillan128@gmail.com";
    };
  };
}
