function nv --description "Neovim startup, but better"
  if test "m" = $argv[1] -o "mail" = $argv[1]
    nvim -c :Notmuch
  end

  if test "cd" = $argv[1] -o "fz" = $argv[1]
    if test -d $argv[2]
      set -l fzroot $argv[2]
    else
      set -l fzroot ~
    end

    set -l dir (find "$fzroot" -type d | fzf --prompt "Enter directory: ")
    if test -z "$dir"
      return 1
    end

    cd $dir; and nvim $argv[2..-1]
    return 0
  end

  if test -d $argv[1]
    cd $argv[1]
    and nvim $argv[2..-1]
    return 0
  end

  if test -f $argv[1]
    set -l fpath (path resolve $argv[1])
    set -l proot (proot $argv[1])

    cd $proot
    and nvim $fpath $argv[2..-1]
    return 0
  end

  nvim $argv[1..-1]
end
