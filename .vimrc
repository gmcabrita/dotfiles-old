set nocompatible
syntax on
set nowrap
set encoding=utf-8

" vim doesn't play well with fish
set shell=/bin/bash

" Automatically installs plug if it isn't available and installs declared plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Utilities
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

Plug 'editorconfig/editorconfig-vim'

" Git support
Plug 'tpope/vim-fugitive'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Better search via Ack
Plug 'mileszs/ack.vim'

" Language-specific support
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-monotone'

call plug#end()

filetype plugin indent on

""" Regular vim configuration starts here

" History settings
set history=1000
set undolevels=1000

" Set the terminal title at will
set title

" Automatically update files when they've been changed externally
set autoread

" A better leader key
let mapleader = ","
let g:mapleader = ","

" Backspace
set backspace=indent,eol,start

" Fast saving
nmap <leader>w :w!<cr>

" 7 Lines to the cursor
set so=10

" Always show where I am in a buffer
set ruler
set relativenumber
set cursorline

" Height of the command bar
set cmdheight=1

" Hide a buffer when it is abandoned
set hid

" Mouse support
if has('mouse')
	set mouse=a
endif

" Ignore case when searching
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Show matching brackets
set showmatch
set mat=2

" No sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Colors, fonts
" set t_Co=256
set background=dark
colorscheme monotone

" Vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

if (has("termguicolors"))
  set termguicolors
endif

set t_ut=

" Why use vim backup when git exists
set nobackup
set nowb
set noswapfile

""" Tabs and indentation

" Use spaces, because tabs are evil
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" line break on excessive lines
set lbr
set tw=500

" Map <Space> to / (search)
map <Space> /

" jj to throw you into normal mode from insert mode
inoremap jj <esc>

" jk to throw you into normal mode from insert mode
inoremap jk <esc>

" Tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" ctrl-backspace should delete words
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

":W to do the same as :w
command! W  write

" better buffer cicle (Tab and Shift+Tab)
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>

" Toggle paste on and off
map <leader>pp :setlocal paste!<cr>

" Always show the status line
set laststatus=2

" Plugin mappings
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

" reload .vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" remove whitespace
nnoremap <Leader>rws :%s/\s\+$//e<CR>

" Commit messages should always wrap at 72 chars
autocmd Filetype gitcommit setlocal spell textwidth=72

" EditorConfig options to deal with fugitive support
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" FZF configuration
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

" filetypes
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile Berksfile,Gemfile,*.gemspec,*.ru set filetype=ruby
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd filetype make setlocal noexpandtab
autocmd filetype c,cpp,java,lua,prolog,python setlocal shiftwidth=4 softtabstop=4

""" Old shit

" status bar
" set noshowmode
" set shortmess=atI
" set showcmd

" files
" set hidden

" preferences
" set autoindent
" set smartindent
" set number
" set linebreak
" set nojoinspaces
