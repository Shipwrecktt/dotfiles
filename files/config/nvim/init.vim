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
