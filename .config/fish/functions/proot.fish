function proot
  set -l target $argv[1]
  if test -z "$target"
    set target_path (pwd)
  end

  set -l cwd $target
  if test -f $target
    set cwd (dirname "$target")
  end

  set -l markers .git flake.nix shell.nix package.json Cargo.toml pyproject.toml
  set -l levels 0
  while test "$cwd" != "/" -a $levels -lt 3
    for marker in $markers
      if test -e "$cwd/$marker"
        echo $cwd
        return 0
      end
    end
    set cwd (dirname "$cwd")
    set levels (math $levels + 1)
  end

  if test -f $target
    dirname "$target"
  else
    dirname (string trim -r -c '/' $target)
  end
end
