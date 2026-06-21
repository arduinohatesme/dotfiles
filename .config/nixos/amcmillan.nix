{ pkgs, ... }: {
  home.username = "amcmillan";
  home.homeDirectory = "/home/amcmillan";
  home.stateVersion = "26.05";

  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#(hostname)";
      gac = "git add -A && git commit";
    };
    interactiveShellInit = ''
fastfetch

# pnpm
set -gx PNPM_HOME "/home/amcmillan/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim
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
}
