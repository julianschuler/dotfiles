function fish_user_key_bindings
    bind \b backward-kill-word
    bind \ct __fzf_find_file
    bind \cr __fzf_reverse_isearch
    bind \ce '__fzf_open --editor'
end
