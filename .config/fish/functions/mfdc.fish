function mfdc --argument encrypted
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
  age -d -i "$key_path" "$encrypted" | age -d -o "$out"
  shred -u "$key_path"
end
