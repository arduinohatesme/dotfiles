#!/usr/bin/env fish
set -l dir (fd -H . ~ | fzf --prompt "Enter nvim dir: ")
cd $dir
nvim
