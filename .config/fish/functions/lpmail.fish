function lpmail
    set -l working (pwd)
    cd ~/Mail/launchpad/; and gmi $argv; and notmuch new
    cd $working
end
