#!/bin/env fish

git clone --bare https://github.com/arduinohatesme/dotfiles.git ~/dotfiles
alias -s config='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias -s cfg='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
config checkout -f
