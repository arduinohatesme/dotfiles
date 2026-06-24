# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, hostName, ... }:

let
  sddm-file = import ./sddm.nix { inherit pkgs; };

  ttheme = if hostName == "super-beast-lx" then
    "mountain"
  else if hostName == "launchpad-9" then
    "black_hole"
  else
    "mountain";

  sddm-theme = sddm-file.${ttheme};

in {
  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."amcmillan" = {
    isNormalUser = true;
    description = "amcmillan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  home-manager = {
    extraSpecialArgs = { theme = ttheme; };
    users.amcmillan = ./amcmillan.nix;
  };

  environment.shellAliases = {
    zen-browser = "zen";
    gac = "git add -A && git commit";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # NVIDIA Driver settings
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  programs.nix-ld.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Basics
    kitty
    fd
    ripgrep
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    sddm-theme
    yazi
  # Development
    neovim
    tree-sitter
    github-cli
    git
    nodejs_26
    cargo
    rustc
    gcc
    tailscale
    ffmpeg
    uv
    python3
  # Terminal
    fish
    fastfetch
  # Hyprland
    rofi
    waybar
    mpvpaper
    awww
    hyprpicker
    hypridle
    hyprpolkitagent
    bibata-cursors
  ];

  fonts.fontconfig.enable = true;
  environment.pathsToLink = [ "/share/icons" ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = 24;
    WLR_RENDERER_ALLOW_SOFTWARE_CURSORS = "1";
  };

  services = {
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

    tailscale = {
      enable = true;
    };

    xserver.enable = true;
  };

  systemd.services.sddm.environment = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    WLR_RENDERER_ALLOW_SOFTWARE_CURSORS = "1";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/sddm/.config 0755 sddm sddm - -"
    "f /var/lib/sddm/.config/kwinoutputconfig.json 0644 sddm sddm - {\"data\":[{\"lidClosed\":false,\"outputs\"[{\"enabled\":true,\"outputIndex\":0,\"position\":{\"x\":0,\"y\":0},\"priority\":0}.{\"enabled\":true,\"outputIndex\":1,\"position\":{\"x\":0,\"y\":0},\"priority\":0}]}],\"name\":\"setups\"}"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
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
