function nvcd
     cd (find ~ -type d | fzf --prompt "Enter directory: ")
     nvim
end
