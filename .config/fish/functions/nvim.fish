function nvim --description "Neovim startup, but better"
  if test "q" = "$argv[1]"
    command nvim $argv[2..-1]
    return 0
  end

  if test "m" = "$argv[1]" -o "mail" = "$argv[1]"
    command nvim -c :Notmuch
  end

  if test "cd" = "$argv[1]" -o "fz" = "$argv[1]"
    set -l fzroot ~
    if test -d "$argv[2]"
      set fzroot "$argv[2]"
    end

    set -l dir (find "$fzroot" -type d | fzf --prompt "Enter directory: ")
    if test -z "$dir"
      return 1
    end

    cd $dir; and command nvim "$argv[2..-1]"
    return 0
  end

  if test -d "$argv[1]"
    cd "$argv[1]"
    and command nvim "$argv[2..-1]"
    return 0
  end

  if test -f "$argv[1]"
    set -l fpath (path resolve "$argv[1]")
    set -l proot (proot "$argv[1]")

    cd $proot
    and command nvim $fpath "$argv[2..-1]"
    return 0
  end

  command nvim "$argv[1..-1]"
end
