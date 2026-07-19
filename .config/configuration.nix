# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  lib,
  hostName,
  fenix,
  ...
}:

let
  sddm-file = import ./sddm.nix { inherit pkgs; };

  ttheme =
    if hostName == "super-beast-lx" then
      "black_hole"
    else if hostName == "launchpad-9" then
      "sakura"
    else if hostName == "beast-jr" then
      "mountain"
    else if hostName == "knicks-os" then
      "black_hole"
    else
      "mountain";

  sddm-theme = sddm-file.${ttheme};

in
{
  # Bootloader.
  boot = {
    loader = {
      efi = {
        efiSysMountPoint = lib.mkIf (hostName == "super-beast-lx") "/boot/efi";
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 3;
        useOSProber = lib.mkIf (hostName == "super-beast-lx") true;
      };

      timeout = 0;
    };

    initrd = {
      kernelModules =
        if hostName == "knicks-os" then
          [ "i915" ]
        else
          [
            "nvidia"
            "nvidia_modeset"
            "nvidia_uvm"
            "nvidia_drm"
          ];
      compressor = "zstd";
      systemd.enable = true;
    };

    supportedFilesystems = [
      "vfat"
      "ext4"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "console=tty1"
      "8250.nr_uarts=0"
      "reboot=acpi"
      "nvidia.NVred_PreserveVideoMemoryAllocation=1"
      "nvidia_drm.fbdev=1"
      "pcie_aspm=off"
    ];
  };

  networking.hostName = hostName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Matamoros";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    unifont
    orbitron
    oswald
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.libvirtd.enable = true;

  programs = {
    fish.enable = true;
    virt-manager.enable = true;
    fuse.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        glibc
        glib
        brotli
        unixodbc
      ];
    };

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."amcmillan" = {
    isNormalUser = true;
    description = "amcmillan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };
  home-manager = {
    extraSpecialArgs = {
      theme = ttheme;
    };
    users.amcmillan = ./amcmillan.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        FastConnectable = true;
        DiscoverableTimeout = 0;
      };
      Policy.AutoEnable = true;
    };
  };
  hardware.graphics.enable = true;

  # Driver settings
  hardware.nvidia = lib.mkIf (hostName != "knicks-os") {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.graphics.extraPackages = lib.optionals (hostName == "knicks-os") [
    pkgs.intel-media-driver
  ];

  nixpkgs.overlays = [ fenix.overlays.default ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Basics
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    sddm-theme
    yazi

    # Development
    neovim
    tree-sitter
    github-cli
    git
    tailscale
    nodejs_26
    gnumake
    gcc

    # TS Parsers
    tree-sitter-grammars.tree-sitter-python
    tree-sitter-grammars.tree-sitter-lua
    tree-sitter-grammars.tree-sitter-rust
    tree-sitter-grammars.tree-sitter-javascript
    tree-sitter-grammars.tree-sitter-typescript
    tree-sitter-grammars.tree-sitter-c

    # Neovim LSPs
    basedpyright
    ruff
    typescript-language-server
    vscode-langservers-extracted
    prettier
    yaml-language-server
    clang-tools
    nixd
    nixfmt
    stylua
    actionlint
    rust-analyzer
    vscode-extensions.vadimcn.vscode-lldb.adapter
    cmake-language-server
    cmake-lint
    markdownlint-cli2
    markdown-toc
    vscode-js-debug
    golangci-lint
    gotools
    gofumpt
    gomodifytags
    impl
    delve
    sqlfluff
    hadolint

    # Rust Tools
    pkg-config
    (pkgs.fenix.combine [
      pkgs.fenix.stable.cargo
      pkgs.fenix.stable.rustc
      pkgs.fenix.stable.clippy
      pkgs.fenix.stable.rust-src
      pkgs.fenix.latest.rustfmt
    ])

    # Python Tools
    python313
    uv

    # Terminal
    kitty
    ripgrep
    fish
    fastfetch
    fishPlugins.bang-bang
    eza
    zoxide
    fd
    fzf

    # Hyprland
    rofi
    mpvpaper
    awww
    hyprpicker
    hyprpolkitagent
    bibata-cursors
    grim
    grimblast
    slurp
    quickshell
    hypridle
    hyprshutdown

    # Others (security, utility, ...)
    age
    localsend
    zip
    unzip
    notmuch
    lieer
    psmisc
  ];

  fonts.fontconfig.enable = true;
  environment.pathsToLink = [ "/share/icons" ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = 24;
    WLR_RENDERER_ALLOW_SOFTWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = lib.optionals (hostName != "knicks-os") [ "nvidia" ];
    };
    displayManager = {
      sddm = {
        enable = true;
        theme = "${sddm-theme}/share/sddm/themes/sddm-astronaut-theme";
        wayland = {
          enable = false;
        };
        package = pkgs.kdePackages.sddm;

        settings = {
          Theme = {
            CursorTheme = "Adwaita";
            CursorSize = 24;
          };
        };

        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtdeclarative
          kdePackages.qt5compat
          kdePackages.qtmultimedia
          sddm-theme
        ];
      };
      defaultSession = "hyprland-uwsm";
    };

    upower.enable = true;
    dbus.enable = true;
    blueman.enable = true;
    tailscale.enable = true;
    xserver.enable = true;
    printing.enable = true;
    openssh = {
      enable = true;
      ports = [ ];
      settings = {
        PermitRootLogin = "no";
        MaxAuthTries = 3;
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      config = {
        common.default = [
          "gtk"
        ];
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

  systemd = {
    services = {
      systemd-udev-settle.enable = false;
      sddm.environment = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
        WLR_RENDERER_ALLOW_SOFTWARE_CURSORS = "1";
      };

      hyprland-suspend = {
        description = "Suspend Hyprland Session";
        before = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
          "nvidia-suspend.service"
          "nvidia-hibernate.service"
        ];
        wantedBy = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.procps}/bin/killall -STOP Hyprland";
        };
      };
    };

    tmpfiles.rules = [
      "d /var/lib/sddm/.config 0755 sddm sddm - -"
      "f /var/lib/sddm/.config/kwinoutputconfig.json 0644 sddm sddm - {\"data\":[{\"lidClosed\":false,\"outputs\"[{\"enabled\":true,\"outputIndex\":0,\"position\":{\"x\":0,\"y\":0},\"priority\":0}.{\"enabled\":true,\"outputIndex\":1,\"position\":{\"x\":0,\"y\":0},\"priority\":0}]}],\"name\":\"setups\"}"
    ];

    settings.Manager = {
      DefaultTimeoutStopSec = "5s";
    };

    user.services.obex = {
      serviceConfig = {
        ExecStart = [
          ""
          "${pkgs.bluez}/libexec/bluetooth/obexd -n -r %h/Downloads/Bluetooth"
        ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [
      41641
      53317
    ];
    trustedInterfaces = [ "tailscale0" ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
