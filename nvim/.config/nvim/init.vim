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
set cursorline
set background=dark


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
tnoremap ;a <C-\><C-n>
inoremap ;a <Esc>



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
" Plug 'gruvbox-community/gruvbox'
" Plug 'ellisonleao/gruvbox.nvim'
" Plug 'folke/tokyonight.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
" Plug 'EdenEast/nightfox.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-git'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'b0o/SchemaStore.nvim'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'shootex/nvim-treesitter-angular'

Plug 'folke/trouble.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'hoob3rt/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

Plug 'folke/todo-comments.nvim'
Plug 'folke/twilight.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

Plug 'ThePrimeagen/harpoon'

Plug 'nvim-telescope/telescope-project.nvim'

Plug 's1n7ax/nvim-comment-frame'

Plug 'nvim-telescope/telescope-symbols.nvim'

Plug 'stevearc/gkeep.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-neorg/neorg'

Plug 'sbdchd/neoformat'

Plug 'windwp/nvim-autopairs'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'wakatime/vim-wakatime'

Plug 'rgroli/other.nvim'

Plug 'rcarriga/nvim-notify'

Plug 'reisub0/hot-reload.vim' "flutter hot reload

Plug 'pwntester/octo.nvim'
call plug#end()

colorscheme onenord

lua require("stx")

let g:netrw_liststyle=3

let test#strategy = "neovim"
let g:test#typescript#runner = "jest"
let g:test#javascript#runner = 'jest'
let test#javascript#jest#options = "--color=always"

let g:ultest_use_pty = 1

let g:maximizer_default_mapping_key = '<C-W>m'

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
