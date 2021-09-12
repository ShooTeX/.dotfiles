syntax on

set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set incsearch
set scrolloff=8
set termguicolors
set signcolumn=yes
set nowrap
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set splitbelow
set splitright
set colorcolumn=120


set path+=**
"Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set clipboard=unnamedplus

let mapleader = " "
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-angular'

Plug 'pantharshit00/vim-prisma'

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'folke/trouble.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'pwntester/octo.nvim'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'hoob3rt/lualine.nvim'

Plug 'folke/todo-comments.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'dbeniamine/cheat.sh-vim'

Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

Plug 'ThePrimeagen/harpoon'
call plug#end()

colorscheme gruvbox
set background=dark

lua require("stx")

let g:netrw_liststyle=3

let test#strategy = "neovim"

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
