function nvcd
     cd (fzf . --prompt "Enter directory: ")
     nvim
end
