function cfg --wraps='git --git-dir=$HOME/dotfiles --work-tree=$HOME' --description 'alias cfg=git --git-dir=$HOME/dotfiles --work-tree=$HOME'
    git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
end
