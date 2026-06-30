function wgh
  if not test -f ~/.config/github-token.age
    echo "Error: ~/.config/github-token.age: file not found"
    return 1
  end

  set -lx GH_TOKEN (age -d -i ~/.ssh/id_ed25519 ~/.config/github-token.age 2>/dev/null)

  if test -z "$GH_TOKEN"
    echo "Error: ~/.config/github-token.age: decryption failed"
    return 1
  end

  $argv
end
