if status is-interactive
end

set fish_greeting

starship init fish | source

set -gx EDITOR nvim

function fish_user_key_bindings
  fish_vi_key_bindings
end

# Emulates Vim's Cursor Shape Behavior
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

abbr grep "grep --color=auto"
abbr tree pstree
abbr P cd ~/Programming
abbr C cd ~/.config
abbr Cs cd ~/.config/suckless
abbr weather curl wttr.in

# Neovim as man reader
set -gx MANPAGER 'nvim +Man!'


# % to make a new file
abbr note nvim ~/Documents/notes/random/
abbr todo nvim ~/Documents/notes/todo.md
