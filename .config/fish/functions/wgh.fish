function wgh
  set -l key_path "$HOME/Downloads/key.key"
 
  echo "Waiting for key..."
  for i in (seq 1 15)
    if test -f "$key_path"
      echo "Key recieved."
      break
    end
    sleep 1
  end

  if test ! -f "$key_path"
    echo "error: decrypt: Key not found"
    return 1
  end

  set -l out (string replace -r '\.age$' '' "$encrypted")
  set -lx GH_TOKEN (age -d -i "$key_path" "$HOME/.config/github-token.age" | age -d)

  shred -u "$key_path"
  echo "Key shredded."

  if test -z "$GH_TOKEN"
    echo "error: decrypt: Error decrypting"
    return 1
  end

  $argv
end
