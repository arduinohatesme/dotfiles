function mfdc --argument encrypted
  set -l key_path "$HOME/Downloads/key.key"
  if test ! -f "$key_path"
    echo "error: decrypt: Key not found"
    return 1
  end
  set -l out (string replace -r '\.age$' '' "$encrypted")
  age -d -i "$key_path" "$encrypted" | age -d -o "$out"
  shred -u "$key_path"
end
