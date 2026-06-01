source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# pnpm
set -gx PNPM_HOME "/home/amcmillan/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function nvcd
    set -l dir fzf --prompt "Type directory to open nvim in: "

    cd "$dir"
    commandline -f repaint
    nvim
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim

nvm use lts 2>&1 >/dev/null
