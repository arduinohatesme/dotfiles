function sudo
    if test "$argc" = "!!"
        eval sudo $history[1]
    else
        command sudo $argv
    end
end
