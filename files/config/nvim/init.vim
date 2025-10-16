syntax on

" Sets file format and encoding
set fileformat=unix
set encoding=UTF-8

" Highlights the current line
highlight CursorLine guibg=#5f0087
set cursorline

" Enable search highlighting
set hlsearch

" Show the status bar
set laststatus=2

" Tab and indentation settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab

" Line numbering
set number
set relativenumber

" Keep 8 lines visible above/below the cursor when scrolling
set scrolloff=8

" Improved split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC
augroup END

" Use system clipboard
set clipboard=unnamedplus

call plug#begin('~/.config/nvim/plug')

" List your plugins here
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'jceb/vim-orgmode'

call plug#end()

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set linebreak
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  set nolinebreak
  " ...
endfunction

let g:goyo_width='80%'
let g:goyo_height='80%'

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
