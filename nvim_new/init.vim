set completeopt=menu,menuone,noselect

:lua require'plugins'

let mapleader=" "
set mouse=nv
" navigation

nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> <A-k> :m--<CR>
nnoremap <silent> <A-j> :m+<CR>

tnoremap <C-T> <C-\><C-n> 


set encoding=utf-8
set tabstop=2 expandtab smarttab shiftwidth=2 softtabstop=2 autoindent
set sessionoptions+=options,resize,winpos,terminal
set termguicolors
set backspace=indent,eol,start
set noshowmode
set complete-=i
set smarttab
set autoindent
set incsearch
set ruler
set wildmenu
set scrolloff=5
set sidescrolloff=10
set display+=lastline
set formatoptions+=j
set autoread
set relativenumber


colorscheme tokyonight



" Telescope
nnoremap <silent> <C-P> :Telescope git_files theme=ivy<CR>
nnoremap <silent> <leader>sf :Telescope live_grep <CR>
nnoremap <silent> <C-F> :Telescope current_buffer_fuzzy_find <CR>
nnoremap <silent> <leader>sb :Telescope buffers <CR>
nnoremap <silent> <leader>sr :Telescope registers <CR>
nnoremap <silent> <leader>sj :Telescope jumplist<CR>
nnoremap <silent> <leader>gs :Telescope git_status<CR>
nnoremap <silent> <leader>gc :Telescope git_commits<CR>
nnoremap <silent> <leader>gb :Telescope git_branches<CR>

"NvimTree

nnoremap <silent> <C-e> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR> 

" FLOATERM
let g:floaterm_wintype = 'vsplit'
nnoremap <silent> <C-T> :FloatermToggle<CR>

" Markdown

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format

"Bufferline
nnoremap <silent> <A-,> :BufferLineCyclePrev<CR>
nnoremap <silent> <A-.> :BufferLineCycleNext<CR>

" Trouble

nnoremap <silent> <leader>xq :TroubleToggle quickfix<cr>
nnoremap <silent> <leader>xl :TroubleToggle loclist<cr>


" Formatter
nnoremap <silent> <leader>ff :Neoformat<CR>
