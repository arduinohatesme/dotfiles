function pullall
    #!/usr/bin/env fish
    # similar script in Fish
    # still under construction, need to quiet `git status` more effectively
    
    function update -d 'Update git repo'
        git stash --quiet
        git pull
        git stash apply --quiet
    end
    
    for dir in ./*/
        cd $dir
        git status -sb 2>/dev/null
        if [ $status -eq 0 ]
            set_color red
            echo "Updating $dir…"
            set_color normal
            update
        end
        cd -
    end
end
