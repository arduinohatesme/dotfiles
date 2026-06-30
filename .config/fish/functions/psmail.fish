function psmail
    set -l working (pwd)
    cd ~/Mail/personal/; and gmi $argv; and notmuch new
    cd $working
end
