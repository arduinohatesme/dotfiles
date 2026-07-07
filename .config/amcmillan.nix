{ pkgs, config, theme, ... }:


{
  home.username = "amcmillan";
  home.homeDirectory = "/home/amcmillan";
  home.stateVersion = "26.11";
  home.file = {
    ".config/nvim/lua/extras/dashcols.lua" = {
      text = ''
      return require("extras.allcols").${theme}
      '';
    };

    ".config/waybar/tokens/if-square.css" = {
      text = if theme == "sakura" || theme == "mountain" then
        ''
        @import "squarify.css";
        ''
      else '''';
    };

    ".config/waybar/tokens/colors.css" = {
      text = ''
      @import "${theme}-colors.css";
      '';
    };

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
      text = if theme == "sakura" || theme == "mountain" then
        ''
        @import "./squarify.rasi"
        ''
      else '''';
    };

    ".config/rofi/if-square-lcr.rasi" = {
      text = if theme == "sakura" || theme == "mountain" then
        ''
        @import "./squarify-lcr.rasi"
        ''
      else '''';
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
      rbsrb = "sudo nixos-rebuild switch --flake ~/.config#(hostname) && reboot";
      rbbrb = "sudo nixos-rebuild boot --flake ~/.config#(hostname) && reboot";
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
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
