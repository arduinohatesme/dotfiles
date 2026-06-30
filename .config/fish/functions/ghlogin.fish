function ghlogin
  set -l key_path "$HOME/Downloads/key.key"
  if test ! -f "$key_path"
    echo "error: decrypt: Key not found"
    return 1
  end
  set -l out (string replace -r '\.age$' '' "$encrypted")
  set -gx GH_TOKEN (age -d -i "$key_path" "$HOME/.config/github-token.age" | age -d)
  if test -z "$GH_TOKEN"
    echo "error: decrypt: Error decrypting"
    return 1
  end
  shred -u "$key_path"
end
