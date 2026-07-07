function fish_title
  set -l suffix " - kitty"

  if set -q argv[1]
    echo "$argv[1]$suffix"
  else
    echo (status current-command) " - " (prompt_pwd)$suffix
  end
end
