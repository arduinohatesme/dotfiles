{
  pkgs,
  config,
  inputs,
  theme,
  ...
}:

{
  home.username = "amcmillan";
  home.homeDirectory = "/home/amcmillan";
  home.stateVersion = "26.11";
  home.file =
    let
      ts = inputs.nix-treesitter.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      ".config/nvim/lua/extras/dashcols.lua" = {
        text = ''
          return require("extras.allcols").${theme}
        '';
      };

      ".config/nvim/parser/nix.so".source = "${ts.tree-sitter-nix}/parser";
      ".config/nvim/parser/python.so".source = "${ts.tree-sitter-python}/parser";
      ".config/nvim/parser/rust.so".source = "${ts.tree-sitter-rust}/parser";
      ".config/nvim/parser/typescript.so".source = "${ts.tree-sitter-typescript}/parser";
      ".config/nvim/parser/javascript.so".source = "${ts.tree-sitter-javascript}/parser";

      ".config/rofi/colors.rasi" = {
        text = ''
          @import "~/.config/rofi/colors/${theme}.rasi"
        '';
      };

      ".config/wallpapers/active" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/amcmillan/.config/wallpapers/${theme}";
      };

      ".config/hypr/theme.lua" = {
        text = ''
          return require("device").${theme}
        '';
      };

      ".config/rofi/if-square.rasi" = {
        text =
          if theme == "sakura" || theme == "mountain" then
            ''
              @import "./squarify.rasi"
            ''
          else
            "";
      };

      ".config/rofi/if-square-lcr.rasi" = {
        text =
          if theme == "sakura" || theme == "mountain" then
            ''
              @import "./squarify-lcr.rasi"
            ''
          else
            "";
      };

      ".config/quickshell/services/Theme.qml" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/amcmillan/.config/quickshell/themes/Theme_${theme}.qml";
      };
    };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -a --color=always --group-directories-first --icons=always";
      la = "eza -al --color=always --group-directories-first --icons=always";
      ll = "eza -l --color=always --group-directories-first --icons=always";
      lr = "eza -aT --color=always --group-directories-first --icons=always";
      tree = "eza -aT --color=always --group-directories-first --icons=always";
      rebuild = "sudo nixos-rebuild switch --flake ~/.config#(hostname)";
      rbs = "sudo nixos-rebuild switch --flake ~/.config#(hostname)";
      rbb = "sudo nixos-rebuild boot --flake ~/.config#(hostname)";
      rbrb = "sudo nixos-rebuild boot --flake ~/.config#(hostname) && reboot";
    };

    shellAbbrs = {
      g = "git";
      ga = "git add";
      gaa = "git add -A";
      gm = "git commit -m";
      gam = "git add -A && git commit -m";
      c = "cfg";
      ca = "cfg add";
      caa = "cfg add -A";
      cm = "cfg commit -m";
      cam = "cfg add -A && cfg commit -m";
      e = "yazi";
      n = "nvim";
      cl = "clear";
    };

    interactiveShellInit = ''
      fastfetch

      # pnpm
      set -gx PNPM_HOME "/home/amcmillan/.local/share/pnpm"
      if not string match -q -- "$PNPM_HOME/bin" $PATH
        set -gx PATH "$PNPM_HOME/bin" $PATH
      end
      # pnpm end

      zoxide init fish --cmd d | source

      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx SUDO_EDITOR nvim
      set -gx MANPAGER "nvim +Man!"
      set -gx MOZ_ENABLE_WAYLAND 1
      set -gx NIXOS_OZONE_WL 1
      set -gx EGL_PLATFORM wayland

      fish_vi_key_bindings
    '';
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";

      font_family = "JetBrainsMono Nerd Font";
      font_size = 11.0;
      disable_ligatures = "cursor";
      confirm_os_window_close = 0;
      background = "#111";
      "map ctrl+shift+h" = "no_op";
      "map ctrl+shift+j" = "no_op";
      "map ctrl+shift+k" = "no_op";
      "map ctrl+shift+l" = "no_op";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
