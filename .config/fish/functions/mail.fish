function mail
    set -l working (pwd)
    cd ~/Mail/gmail/; and gmi $argv; and notmuch new
    cd $working
end
